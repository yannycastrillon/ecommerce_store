class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :is_admin?

  def is_admin?
    return true if current_user.admin?
    redirect_to root_path, flash: {error: "Warning! Only Admin privileges"}
  end
end
