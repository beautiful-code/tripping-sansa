class UsersController < ApplicationController

  before_filter :authenticate_user!

  def profile
    if request.post?
      current_user.update_attribute(:library_ids, params[:library_ids])
    end
  end
end
