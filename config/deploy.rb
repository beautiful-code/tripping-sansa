
set :rails_root, "#{File.dirname(__FILE__)}/.."
$:.unshift("#{rails_root}/lib")

require 'capistrano/ext/multistage'
require 'yaml'

set :stages, ["production"]
set :default_stage, "production"


before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

set :application, "jaffa"
set :user, 'deploy'


set :deploy_to, "/home/#{user}/#{application}"
set :copy_exclude, [".git/*", ".svn/*", ".DS_Store"]

ssh_options[:forward_agent] = true
ssh_options[:paranoid] = false
default_run_options[:pty] = true
ssh_options[:auth_methods] = %w(publickey)


after "deploy:restart", "deploy:cleanup"

=begin
after "deploy:update_code", "mongoid:configure"
after "deploy:update_code", "nginx:configure"
after "deploy:update_code", "sunspot:configure"
after "deploy:update_code", "unicorn:configure"
=end

after 'deploy:update_code' do
  run "mkdir -p #{shared_path}/assets"
  run "ln -nfs #{shared_path}/assets #{release_path}/public/assets; true"
  run "cd #{release_path}; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
end

namespace :deploy do

  task :start, roles: [:app] do
    unicorn.start
  end

  task :stop, roles: [:app] do
    unicorn.stop
  end

  task :restart, roles: [:app] do
    true
  end
end

namespace :mongoid do
  desc "configures mongoid"
  task :configure do
    template_configure 'mongoid.yml'
  end

  task :create_indexes, roles: [:db] do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake db:mongoid:create_indexes"
  end

  task :remove_indexes, roles: [:db] do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake db:mongoid:remove_indexes"
  end

  task :reindex, roles: [:db] do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake db:mongoid:reindex"
  end
end

namespace :nginx do
  desc "configures nginx"
  task :configure, roles: [:web] do
    template_configure 'nginx.conf'
  end

  [ :start, :stop, :restart, :status ].each do |action|
    task action do
      sudo "service nginx #{action}"
    end
  end


end

namespace :sunspot do
  desc "configures sunspot"
  task :configure, roles: [:web] do
    template_configure 'sunspot.yml'
  end
end

set :unicorn_config_path, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"

namespace :unicorn do
  desc "configures unicorn"
  task :configure, :roles => [:web] do
    template_configure 'unicorn.rb'
  end
end

#require 'capistrano-unicorn'
require 'rvm/capistrano'
require 'bundler/capistrano'
#require 'capistrano/utils'