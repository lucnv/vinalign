class AddDataToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :data, :hstore, default: {}, null: false
  end
end
