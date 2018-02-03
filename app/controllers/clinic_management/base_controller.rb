class ClinicManagement::BaseController < ApplicationController
  before_action :authenticate_doctor!

  layout "clinic_management"

  helper_method :current_clinic

  private
  def authenticate_doctor!
    raise Pundit::NotAuthorizedError unless current_user.try :doctor?
  end

  def current_clinic
    @current_clinic ||= current_user.clinic
  end
end
