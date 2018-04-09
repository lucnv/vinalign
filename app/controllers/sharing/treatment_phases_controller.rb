class Sharing::TreatmentPhasesController < ApplicationController
  def show
    @patient_record = PatientRecord.find_by!(public_token: params[:patient_record_id], is_sharing: true)
    @treatment_phase = @patient_record.treatment_phases.find params[:id]
    @albums = @treatment_phase.albums.recent_end_date
    if params[:album_id].present?
      @current_album = @treatment_phase.albums.find(params[:album_id])
    else
      @current_album = @albums.first
    end
  end
end
