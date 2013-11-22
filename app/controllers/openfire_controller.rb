class OpenfireController < ApplicationController
  before_filter :check_for_inputs, :add_user

  def add_user

    base_url = "http://#{AppConfig.openfire.host}:#{AppConfig.openfire.port}"

    conn = Faraday.new(:url => base_url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    path = "plugins/userService/userservice"

    resp = conn.get do |req|
      req.url path, {
        :type => 'add', 
        :secret => AppConfig.openfire.secret,
        :username => params[:username],
        :password => AppConfig.openfire.user_password,
        :name => params[:name],
        :email => params[:email]
      }
    end

    debugger

    if resp.body =~ /<result>ok<\/result>/
      User.create!(:email => "#{params[:username]}@jaffa.co",
                   :password => AppConfig.openfire.user_password,
                   :password_confirmation => AppConfig.openfire.user_password)
    end

    render :text => resp.body
  end

  def check_for_inputs
    unless params[:username].present?
      render :text => 'username not present'
    end
  end
end


#http://vagrant-ubuntu-precise-64:9090/plugins/userService/userservice?type=add&secret=secret&username=kafka&password=password&name=franz&email=franz@kafka.com
