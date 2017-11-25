class Clinic::TreatmentPhasesController < Clinic::BaseController  
  before_action :patient_record, only: [:index, :new, :create]

  def index
    @treatment_phases = @patient_record.treatment_phases
  end

  def new
    @treatment_phase = TreatmentPhase.new
  end

  def create
    @treatment_phase = @patient_record.treatment_phases.build treatment_phase_params
    if @treatment_phase.save 
      flash[:success] = t ".success"
      redirect_to clinic_patient_record_treatment_phases_path(@patient_record)
    else
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  private
  def patient_record
    @patient_record = PatientRecord.find params[:patient_record_id]
  end

  def treatment_phase_params
    params.require(:treatment_phase).permit TreatmentPhase::ATTRIBUTES
  end
end
