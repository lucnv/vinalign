class NotificationDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  def target_path
    hash_value[:target_path]
  end

  def message
    hash_value[:message]
  end

  private
  def hash_value
    @hash_value ||= case action.to_sym
    when :new_patient_record
      {
        target_path: admin_patient_record_path(self.notifiable),
        message: "new record"
      }
    when :new_images_uploaded
      {
        target_path: "",
        message: "image uploaded"
      }
    end
  end
end
