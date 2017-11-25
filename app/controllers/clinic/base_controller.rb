class Clinic::BaseController < ApplicationController 
  before_action :authenticate_doctor!

  layout "clinic"

  private
  def authenticate_doctor!
    raise Pundit::NotAuthorizedError unless current_user.try :doctor?
  end

  def clinic
    @clinic = current_user.clinic
  end
end
