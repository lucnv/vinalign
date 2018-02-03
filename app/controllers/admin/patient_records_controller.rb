class Admin::PatientRecordsController < Admin::BaseController
  def index
    @clinic = Clinic.find params[:clinic_id]
    @q = @clinic.patient_records.ransack params[:q]
    @patient_records = @q.result.recent_created.page(params[:page])
      .per(Settings.patient_records.per_page).includes(:clinic).decorate
  end

  def show
    @patient_record = PatientRecord.find(params[:id]).decorate
  end
end
