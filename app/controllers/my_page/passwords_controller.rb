class MyPage::PasswordsController < MyPage::BaseController
  def edit
  end

  def update
    if current_user.update_with_password(update_password_params) && update_password_params[:password].present?
      bypass_sign_in current_user
      flash[:success] = t ".success"
      redirect_to my_page_profile_path
    else
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  private
  def update_password_params
    params.require(:user).permit User::UPDATE_PASSWORD_PARAMS
  end
end
