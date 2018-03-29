class NotifyUpdatePriceListService
  attr_reader :patient_record

  def initialize patient_record
    @patient_record = patient_record
  end

  def perform
    notification = patient_record.clinic.doctor.received_notifications
      .where(created_at: 1.hour.ago..Time.zone.now)
      .find_or_initialize_by notifiable: patient_record, action: :price_list_uploaded
    notification.assign_attributes is_read: false
    notification.save
  end
end
