class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :action
      t.references :notifiable, polymorphic: true
      t.boolean :is_read, default: false

      t.timestamps
    end

    add_index :notifications, :recipient_id
  end
end
