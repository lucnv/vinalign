class Clinic < ApplicationRecord
  belongs_to :district
  has_one :doctor_profile
  has_many :patient_records
end
