class MyPage::NotificationsController < MyPage::BaseController
  def index
    @notifications = current_user.user_profile.received_notifications.recent_created
      .page(params[:page]).per(Settings.notifications.per_page).decorate
  end
end
