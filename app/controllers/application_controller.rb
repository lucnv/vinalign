class ApplicationController < ActionController::Base
  include Pundit
  before_action :set_locale
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :no_permission

  private
  def no_permission
    flash[:alert] = t "no_permission"
    redirect_back fallback_location: root_path
  end

  def after_sign_in_path_for resource_or_scope
    stored_location_for(resource) || if current_user.admin?
      admin_root_path
    else
      clinic_management_root_path
    end
  end

  def set_locale
    I18n.locale = :vi
  end

  def require_sign_in!
    return if user_signed_in?
    flash[:alert] = t "require_sign_in"
    store_location_for :user, request.referer
    respond_to do |format|
      format.js {render ajax_redirect_to(new_user_session_path)}
      format.html {redirect_to new_user_session_path}
    end
  end
end
