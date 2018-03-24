class Admin::TreatmentPhasesController < Admin::BaseController
  TABS = %w(images treatment_plans communication)
  before_action :patient_record, only: [:index, :new, :create]

  def index
    @treatment_phases = @patient_record.treatment_phases
  end

  def new
    @treatment_phase = TreatmentPhase.new
    @treatment_phase.start_date = Time.zone.now
  end

  def create
    @treatment_phase = @patient_record.treatment_phases.build treatment_phase_params
    if @treatment_phase.save
      flash[:success] = t ".success"
      redirect_to admin_treatment_phase_path @treatment_phase
    else
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  def show
    @treatment_phase = TreatmentPhase.find params[:id]
    @support = Supports::TreatmentPhase.new @treatment_phase
  end

  private
  def patient_record
    @patient_record = PatientRecord.find params[:patient_record_id]
  end

  def treatment_phase_params
    params.require(:treatment_phase).permit TreatmentPhase::ATTRIBUTES
  end

  def active_tab
    TABS.include?(params[:tab]) ? params[:tab] : TABS.first
  end

  helper_method :active_tab
end
