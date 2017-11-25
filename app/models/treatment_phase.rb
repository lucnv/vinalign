class TreatmentPhase < ApplicationRecord
  ATTRIBUTES = [:name, :start_date, :description]

  belongs_to :patient_record
  has_many :messages
  has_many :albums

  validates :name, presence: true
  validates :start_date, presence: true
end
