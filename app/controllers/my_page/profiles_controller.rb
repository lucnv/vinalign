class MyPage::ProfilesController < MyPage::BaseController

  def show
  end

  def edit
    @profile = current_user.user_profile
  end

  def update
    @profile = current_user.user_profile
    @profile.assign_attributes profile_params
    if @profile.save
      flash[:success] = t ".success"
      redirect_to my_page_profile_path
    else
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  private
  def profile_params
    params.require(:user_profile).permit UserProfile::UPDATE_PROFILE_PARAMS
  end
end
