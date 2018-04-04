class AddCreaterToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_reference :notifications, :creator
  end
end
