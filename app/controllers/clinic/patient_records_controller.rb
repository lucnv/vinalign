class Clinic::PatientRecordsController < Clinic::BaseController
  before_action :clinic, only: [:index, :create]

  def index 
    @patient_records = @clinic.patient_records.recent_created.page(params[:page])
      .per(Settings.patient_records.per_page).decorate
  end

  def new
    @patient_record = PatientRecord.new
    support_for_patient_record
  end

  def create
    @patient_record = @clinic.patient_records.build patient_record_params
    if @patient_record.save 
      flash[:success] = t ".success"
      redirect_to root_path
    else 
      support_for_patient_record
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  private
  def patient_record_params
    params.require(:patient_record).permit PatientRecord::ATTRIBUTES
  end

  def support_for_patient_record
    @support = Supports::PatientRecord.new @patient_record
  end
end
