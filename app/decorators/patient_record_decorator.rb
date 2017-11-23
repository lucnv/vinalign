class PatientRecordDecorator < ApplicationDecorator
  def full_name
    first_name + " " + last_name
  end

  def age
    today = Time.zone.today
    today.year - dob.year - ((today.month > dob.month || (today.month == dob.month && today.day >= dob.day)) ? 0 : 1)
  end

  class << self 
    def collection_decorator_class
      PaginatingDecorator
    end
  end
end
