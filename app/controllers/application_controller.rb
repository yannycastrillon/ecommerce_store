class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :is_admin?

  def is_admin?
    user_signed_in? && current_user.admin? ? true : false
    # redirect_to root_path, flash: {error: "Warning! Only Admin privileges"} and return
  end
end
