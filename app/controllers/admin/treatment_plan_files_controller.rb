class Admin::TreatmentPlanFilesController < Admin::BaseController
  before_action :treatment_phase
  before_action :treatment_plan_file, only: :destroy

  def create
    @treatment_plan_file = @treatment_phase.treatment_plan_files.build treatment_plan_file_params
    if @treatment_plan_file.save
      push_notification
      flash.now[:success] = t ".success"
    else
      flash.now[:failed] = t ".failed"
    end
  end

  def destroy
    if @treatment_plan_file.destroy
      flash.now[:success] = t ".success"
    else
      flash.now[:failed] = t ".failed"
    end
  end

  private
  def treatment_phase
    @treatment_phase = TreatmentPhase.find params[:treatment_phase_id]
  end

  def treatment_plan_file
    @treatment_plan_file = TreatmentPlanFile.find params[:id]
  end

  def treatment_plan_file_params
    {source: params[:sources]}
  end

  def push_notification
    doctor = @treatment_phase.patient_record.clinic.doctor
    doctor.received_notifications.create notifiable: @treatment_plan_file,
      action: :treatment_plan_file_uploaded,
      data: {file_name: File.basename(@treatment_plan_file.source.to_s)},
      creator: current_user.user_profile
  end
end
