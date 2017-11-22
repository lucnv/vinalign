class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!

  private
  def authenticate_admin!
    raise Pundit::NotAuthorizedError unless current_user.try :admin?
  end
end
