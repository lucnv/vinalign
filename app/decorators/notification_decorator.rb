class NotificationDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  def target_path
    hash_value[:target_path]
  end

  def content
    hash_value[:content]
  end

  class << self
    def collection_decorator_class
      PaginatingDecorator
    end
  end

  private
  def hash_value
    @hash_value ||= case action.to_sym
    when :new_patient_record
      patient_record = self.notifiable
      {
        target_path: admin_patient_record_path(patient_record),
        content: I18n.t("notification.content.new_patient_record",
          clinic_name: patient_record.clinic.name)
      }
    when :images_uploaded
      album = self.notifiable
      {
        target_path: admin_treatment_phase_path(album.treatment_phase, tab: :images),
        content: I18n.t("notification.content.images_uploaded",
          clinic_name: album.treatment_phase.patient_record.clinic.name,
          images_count: self.data["images_count"],
          album_name: album.name)
      }
    when :treatment_plan_file_uploaded
      treatment_plan_file = self.notifiable
      {
        target_path: clinic_management_treatment_phase_path(treatment_plan_file.treatment_phase, tab: :treatment_plans),
        content: I18n.t("notification.content.treatment_plan_file_uploaded",
          file_name: self.data["file_name"])
      }
    end
  end
end
