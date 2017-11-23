class PriceList < ApplicationRecord
  ATTRIBUTES = [:item, :price]
  
  belongs_to :patient_record

  validates :item, presence: true
  validates :price, presence: true
end
