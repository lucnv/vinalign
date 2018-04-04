class MyPage::NotificationsController < MyPage::BaseController
  def index
    @unread_count = current_user.user_profile.received_notifications.unread.count
    @notifications = current_user.user_profile.received_notifications.recent_created
      .page(params[:page]).per(Settings.notifications.per_page)
      .includes(:creator).decorate
  end
end
