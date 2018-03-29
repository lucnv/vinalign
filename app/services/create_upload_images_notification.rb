class CreateUploadImagesNotification
  attr_reader :album, :new_images_count

  def initialize album, new_images_count
    @album = album
    @new_images_count = new_images_count
  end

  def perform
    User.admin.includes(:user_profile).each do |user|
      notification = user.user_profile.received_notifications.where(created_at: 1.hour.ago..Time.zone.now)
        .find_or_initialize_by notifiable: album, action: :images_uploaded
      notification.data["images_count"] = notification.data["images_count"].to_i + new_images_count
      notification.assign_attributes is_read: false
      notification.save
    end
  end
end
