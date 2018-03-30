class ClinicManagement::ClinicsController < ClinicManagement::BaseController
  def edit
    @clinic = current_user.user_profile.clinic
    @support = Supports::Clinic.new @clinic
  end

  def update
    @clinic = current_user.user_profile.clinic
    @clinic.assign_attributes clinic_params
    if @clinic.save
      flash[:success] = t ".success"
      redirect_to my_page_profile_path
    else
      @support = Supports::Clinic.new @clinic
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  private
  def clinic_params
    params.require(:clinic).permit Clinic::ADMIN_PERSIT_PARAMS
  end
end
