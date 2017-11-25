class Clinic < ApplicationRecord
  belongs_to :district
  belongs_to :user
  has_many :patient_records
end
