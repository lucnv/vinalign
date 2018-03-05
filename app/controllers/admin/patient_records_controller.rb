class Admin::PatientRecordsController < Admin::BaseController
  before_action :patient_record, except: [:index, :new, :create]
  before_action :clinic, only: [:index, :new, :create]

  def index
    @q = @clinic.patient_records.ransack params[:q]
    @patient_records = @q.result.recent_created.page(params[:page])
      .per(Settings.patient_records.per_page).includes(:clinic).decorate
  end

  def show
    @patient_record = @patient_record.decorate
  end

  def new
    @patient_record = PatientRecord.new.decorate
    @patient_record.start_date = Date.current
    support_for_patient_record
  end

  def create
    @patient_record = @clinic.patient_records.build patient_record_params
    if @patient_record.save
      flash[:success] = t ".success"
      redirect_to admin_patient_record_path(@patient_record)
    else
      support_for_patient_record
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  def edit
    @patient_record = @patient_record.decorate
    support_for_patient_record
  end

  def update
    @patient_record.assign_attributes patient_record_params
    if @patient_record.save
      flash[:success] = t ".success"
      redirect_to admin_patient_record_path(@patient_record)
    else
      support_for_patient_record
      @patient_record = @patient_record.decorate
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @patient_record.destroy
      flash[:success] = t ".success"
    else
      flash[:success] = t ".failed"
    end
    redirect_back fallback_location: admin_root_path
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

  def clinic
    @clinic = Clinic.find params[:clinic_id]
  end
end
