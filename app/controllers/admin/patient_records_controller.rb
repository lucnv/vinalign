class Admin::PatientRecordsController < Admin::BaseController
  def index
    @patient_records = PatientRecord.recent_created.page(params[:page])
      .per(Settings.patient_records.per_page).includes(:clinic).decorate
  end
end
