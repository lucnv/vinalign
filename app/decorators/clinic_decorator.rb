class ClinicDecorator < ApplicationDecorator
  def full_address
    [address, district_name, province_name].compact.join ", "
  end

  class << self
    def collection_decorator_class
      PaginatingDecorator
    end
  end
end
