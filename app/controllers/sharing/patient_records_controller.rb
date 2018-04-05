class Sharing::PatientRecordsController < ApplicationController
  before_action :load_patient_record, :authorize_sharing!, only: [:update, :shared_link]

  def show
    @patient_record = PatientRecord.find_by!(public_token: params[:id], is_sharing: true)
      .decorate
  end

  def update
    @patient_record = PatientRecord.find params[:id]
    authorize_sharing!
    @patient_record.update is_sharing: params[:is_sharing]
    flash.now[:success] = t ".success"
  end

  def shared_link
  end

  private
  def load_patient_record
    @patient_record = PatientRecord.find params[:id]
  end

  def authorize_sharing!
    return unless user_signed_in?
    current_user.admin? || @patient_record.clinic = current_user.user_profile.clinic
  end
end
