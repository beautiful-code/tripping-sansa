class Api::UserSessionsController < Devise::SessionsController

  before_filter :authenticate_user!, :except => [:create, :destroy]
  helper DeviseHelper

  def create
    respond_to do |format|

      format.html do
        self.resource = warden.authenticate!(auth_options)
        set_flash_message(:notice, :signed_in) if is_flashing_format?
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, :location => after_sign_in_path_for(resource)
      end
      format.json do
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        unless self.resource
          invalid_login_attempt
        else
          render :json => {:success => true, :auth_token => resource.authentication_token, :email => resource.email}
        end
      end

    end
  end

  def destroy
    respond_to do |format|
      format.json do
        resource = User.find_for_database_authentication(:email => params[:email])
        resource.authentication_token = nil
        resource.save
        render :json => {:success => true}
      end
      format.html do
        redirect_path = after_sign_out_path_for(resource_name)
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        #set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
        yield resource if block_given?
        redirect_to redirect_path
      end
    end
  end

  protected
   #Dont change this...codes gonna blow up in your face !
  #Functions got from devise helpers.rb
  def request_format
    @request_format ||= request.format.try(:ref)
  end

  def is_navigational_format?
    Devise.navigational_formats.include?(request_format)
  end

  # Check if flash messages should be emitted. Default is to do it on
  # navigational formats
  def is_flashing_format?
    is_navigational_format?
  end



  def invalid_login_attempt
    render :json => {:success => false, :message => "Error with your login or password"}, :status => 401
  end
end