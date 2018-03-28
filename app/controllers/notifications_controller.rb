class NotificationsController < AuthenticatedController
  def index
    respond_to do |format|
      format.js do
        @notifications = current_user.user_profile.received_notifications.recent_created
          .limit(10).decorate
      end
    end
  end
end
