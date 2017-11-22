class District < ApplicationRecord
  belongs_to :province
  has_many :clinics
  has_many :patient_records
end
