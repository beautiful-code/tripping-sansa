class Capistrano::Configuration

  def template_configure(config_file, options = {})
    run "mkdir -p #{shared_path}/config"
    configuration = ERB.new File.read("#{rails_root}/config/#{config_file}.erb")
    put configuration.result(binding), "#{shared_path}/config/#{config_file}", options
    [ release_path, current_path ].each do |p|
      run "ln -nfs #{shared_path}/config/#{config_file} #{p}/config/#{config_file}; true"
    end
  end

  def roles_for_host(host)
    if @roles_for_host.nil?
      @roles_for_host = {}
      roles.keys.each do |role|
        find_servers(:roles => role).each do |s|
          @roles_for_host[s.to_s] ||= []
          @roles_for_host[s.to_s].push(role.to_s)
        end 
      end
    end
    return @roles_for_host[host.to_s]
  end

  def symbolize_keys(map)
    map.clone.each_pair do |key, value|
      map[key.to_sym || key] = value
      if value.kind_of?(Hash)
        symbolize_keys(value)
      end
    end
  end

end
