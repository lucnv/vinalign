class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!, :set_locale

  layout "admin"

  private
  def authenticate_admin!
    raise Pundit::NotAuthorizedError unless current_user.try :admin?
  end

  def set_locale
    I18n.locale = :vi
  end
end
