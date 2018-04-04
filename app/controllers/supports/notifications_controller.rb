class Supports::NotificationsController < ApplicationController
  def index
    respond_to do |format|
      format.js do
        @unread_noti_count = current_user.user_profile.received_notifications.unread.count
        @notifications = current_user.user_profile.received_notifications.recent_created
          .limit(Settings.notifications.on_dropdown_menu).includes(:creator).decorate
      end
    end
  end

  def update
    current_user.user_profile.received_notifications.find(params[:id]).update is_read: true
    render body: nil
  end
end
