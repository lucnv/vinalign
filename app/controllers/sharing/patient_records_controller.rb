class Sharing::PatientRecordsController < ApplicationController
  def show
    @patient_record = PatientRecord.find_by!(public_token: params[:id], is_sharing: true)
      .decorate
  end
end
