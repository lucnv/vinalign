class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :no_permission

  private
  def no_permission
    flash[:alert] = t "no_permission"
    redirect_back fallback_location: root_path
  end

  def after_sign_in_path_for resource_or_scope
    if current_user.admin?
      admin_root_path
    else
      clinic_management_root_path
    end
  end
end
