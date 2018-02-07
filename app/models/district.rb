class District < ApplicationRecord
  belongs_to :province
  has_many :clinics
  has_many :patient_records
  has_many :experts

  scope :name_asc, ->{order name: :asc}
end
