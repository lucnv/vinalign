class Admin::TreatmentPhasesController < Admin::BaseController
  TABS = %w(images treatment_plans communication)
  before_action :patient_record, only: [:index, :new, :create]
  before_action :load_treatment_phase, only: [:edit, :update, :destroy]

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
    else
      flash.now[:failed] = t ".failed"
    end
  end

  def show
    @treatment_phase = TreatmentPhase.find params[:id]
    @support = Supports::TreatmentPhase.new @treatment_phase
  end

  def edit
  end

  def update
    @treatment_phase.assign_attributes treatment_phase_params
    if @treatment_phase.save
      flash.now[:success] = t ".success"
    else
      flash.now[:failed] = t ".failed"
    end
  end

  def destroy
    if @treatment_phase.destroy
      flash.now[:success] = t ".success"
    else
      flash.now[:failed] = t ".failed"
    end
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

  def load_treatment_phase
    @treatment_phase = TreatmentPhase.find params[:id]
  end

  helper_method :active_tab
end
