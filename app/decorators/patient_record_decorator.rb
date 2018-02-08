class PatientRecordDecorator < ApplicationDecorator
  def full_name
    last_name + " " + first_name
  end

  def age
    return unless dob.present?
    today = Time.zone.today
    today.year - dob.year - ((today.month > dob.month || (today.month == dob.month && today.day >= dob.day)) ? 0 : 1)
  end

  def full_address
    [address, district_name, province_name].compact.join ", "
  end

  class << self
    def collection_decorator_class
      PaginatingDecorator
    end
  end
end
