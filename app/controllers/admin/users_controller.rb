class Admin::UsersController < Admin::BaseController
  def index
    @q = User.doctor.ransack params[:q]
    @users = @q.result.page(params[:page]).per(Settings.users.per_page).decorate
  end

  def new
    @user = User.new
    @user.build_user_profile
  end

  def create
    @user = User.new user_params.merge role: :doctor
    if @user.save
      flash[:success] = t ".success"
      redirect_to admin_users_path
    else
      @user.build_user_profile
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit User::ADMIN_PERSIT_PARAMS
  end
end
