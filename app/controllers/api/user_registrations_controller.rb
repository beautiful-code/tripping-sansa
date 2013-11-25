class Api::UserRegistrationsController < Devise::RegistrationsController
  respond_to :json

  #TODO Have to extend Devises Registrations controller to return "authentication_token" ...as of now ...not returning anything I think
end

