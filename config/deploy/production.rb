set :rails_env, "production"
#set :config, -> { YAML.load_file("#{rails_root}/config/app_config.yml")[rails_env] }

server "54.254.137.190", :app, :web, primary:true

# Deploy from local copy
set :scm, :none
set :repository, "."
set :deploy_via, :copy

set :unicorn_config, {
  port: 8000,
  workers: 2
}

set :db_config, {
  host: '0.0.0.0',
  port: 27017,
}

set :use_sudo, false
set :rvm_ruby_string, "ruby-1.9.3-p429"

set :user, "deploy"
set :rvm_type, :user