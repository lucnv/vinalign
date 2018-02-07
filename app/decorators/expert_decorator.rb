class ExpertDecorator < ApplicationDecorator
  def full_address
    [address, district.name, province.name].compact.join ", "
  end

  def full_name
    last_name + " " + first_name
  end

  class << self
    def collection_decorator_class
      PaginatingDecorator
    end
  end
end
