class ClinicManagement::TreatmentPlanFilesController < ClinicManagement::BaseController
  def update
    @treatment_plan_file = TreatmentPlanFile.find params[:id]
    if @treatment_plan_file.update(doctor_opinion: params[:doctor_opinion]) && @treatment_plan_file.doctor_expressed?
      action = @treatment_plan_file.agree? ? :agree_treatment_plan_file : :disagree_treatment_plan_file
      data =  {file_name: File.basename(@treatment_plan_file.source.to_s)}
      CreateNotificationForAdminsService.new(current_user.user_profile, @treatment_plan_file, action, data).perform
      flash.now[:success] = t ".success"
    else
      flash.now[:failed] = t ".failed"
    end
  end
end
