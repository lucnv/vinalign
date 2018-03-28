class Supports::NotificationsController < ApplicationController
  def index
    respond_to do |format|
      format.js do
        @unread_noti_count = current_user.user_profile.received_notifications.unread.count
        @notifications = current_user.user_profile.received_notifications.recent_created
          .limit(Settings.notifications.on_dropdown_menu).decorate
      end
    end
  end
end
