class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :receiver, class_name: UserProfile.name, foreign_key: :recipient_id
  belongs_to :creator, class_name: UserProfile.name, foreign_key: :creator_id

  after_commit :push_notification

  scope :unread, ->{where is_read: false}
  scope :recent_created, ->{order created_at: :desc}

  enum action: [:new_patient_record, :images_uploaded, :treatment_plan_file_uploaded,
    :price_list_uploaded, :agree_treatment_plan_file, :disagree_treatment_plan_file]

  def is_unread?
    !is_read?
  end

  private
  def push_notification
    data = {
      unread_noti_count: self.receiver.received_notifications.unread.count
    }
    NotificationRelayJob.perform_later self.recipient_id, data
  end
end
