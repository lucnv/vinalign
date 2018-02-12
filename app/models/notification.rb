class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :receiver, class_name: UserProfile.name, foreign_key: :recipient_id

  after_commit -> {NotificationRelayJob.perform_later self}

  scope :unread, ->{where is_read: false}

  enum action: [:new_patient_record, :new_images_uploaded]
end
