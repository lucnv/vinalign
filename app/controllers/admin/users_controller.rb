class Admin::UsersController < Admin::BaseController
  def index
    @q = User.doctor.ransack params[:q]
    @users = @q.result.page(params[:page]).per(Settings.users.per_page).decorate
  end
end
