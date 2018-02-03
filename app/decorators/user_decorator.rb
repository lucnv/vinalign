class UserDecorator < ApplicationDecorator
  class << self
    def collection_decorator_class
      PaginatingDecorator
    end
  end
end
