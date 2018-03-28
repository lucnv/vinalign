class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform receiver_id, data
    ActionCable.server.broadcast "notifications:#{receiver_id}", data
  end
end
