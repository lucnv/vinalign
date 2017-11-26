class Admin::TreatmentPlanFilesController < Admin::BaseController 
  before_action :treatment_phase

  def create
    @treatment_plan_file = @treatment_phase.treatment_plan_files.build treatment_plan_file_params
    if @treatment_plan_file.save
      flash.now[:success] = t ".success"
    else
      flash.now[:failed] = t ".failed"
    end
  end

  private
  def treatment_phase
    @treatment_phase = TreatmentPhase.find params[:treatment_phase_id]
  end

  def treatment_plan_file_params
    params.require(:treatment_plan_file).permit :source
  end
end
