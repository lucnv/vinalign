class NotificationRelayJob < ApplicationJob
  def perform notification
    ActionCable.server.broadcast "notifications:#{notification.receiver.user_id}", {}
  end
end
