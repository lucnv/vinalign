class Province < ApplicationRecord
  has_many :districts

  scope :name_asc, ->{order name: :asc}
end
