class Clinic::PatientRecordsController < Clinic::BaseController
  before_action :clinic, only: [:index, :create]
  before_action :patient_record, only: [:edit, :update]

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
      redirect_to clinic_patient_records_path
    else 
      support_for_patient_record
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  def edit
    support_for_patient_record
  end

  def update
    @patient_record.assign_attributes patient_record_params
    if @patient_record.save 
      flash[:success] = t ".success"
      redirect_to clinic_patient_records_path
    else
      support_for_patient_record
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  private
  def patient_record_params
    params.require(:patient_record).permit PatientRecord::ATTRIBUTES
  end

  def patient_record
    @patient_record = PatientRecord.find params[:id]
  end

  def support_for_patient_record
    @support = Supports::PatientRecord.new @patient_record
  end
end
