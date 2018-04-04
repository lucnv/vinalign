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
      doctor = self.creator
      {
        target_path: admin_patient_record_path(patient_record),
        content: I18n.t("notification.content.new_patient_record",
          clinic_name: doctor.clinic.name, patient_name: patient_record.full_name)
      }
    when :images_uploaded
      album = self.notifiable
      doctor = self.creator
      {
        target_path: admin_treatment_phase_path(album.treatment_phase, tab: :images),
        content: I18n.t("notification.content.images_uploaded",
          clinic_name: doctor.clinic.name,
          images_count: self.data["images_count"],
          album_name: album.name,
          patient_name: album.treatment_phase.patient_record.full_name)
      }
    when :treatment_plan_file_uploaded
      treatment_plan_file = self.notifiable
      admin = self.creator
      {
        target_path: clinic_management_treatment_phase_path(treatment_plan_file.treatment_phase, tab: :treatment_plans),
        content: I18n.t("notification.content.treatment_plan_file_uploaded",
          file_name: self.data["file_name"], patient_name: treatment_plan_file.full_name,
          admin_name: admin.full_name)
      }
    when :price_list_uploaded
      patient_record = self.notifiable
      admin = self.creator
      {
        target_path: clinic_management_patient_record_price_lists_path(patient_record_id: patient_record.id),
        content: I18n.t("notification.content.price_list_uploaded", patient_name: patient_record.full_name,
          admin_name: admin.full_name)
      }
    end
  end
end
