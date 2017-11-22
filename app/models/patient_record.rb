class PatientRecord < ApplicationRecord
  belongs_to :clinic
  belongs_to :district
  has_many :treatment_phases
end
