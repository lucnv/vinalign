class TreatmentPhase < ApplicationRecord
  ATTRIBUTES = [:name, :start_date, :description]

  has_many :messages
  has_many :albums

  validates :name, presence: true
  validates :start_date, presence: true
end
