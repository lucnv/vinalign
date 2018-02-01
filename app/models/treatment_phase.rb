class TreatmentPhase < ApplicationRecord
  ATTRIBUTES = [:name, :start_date, :description]

  belongs_to :patient_record
  has_many :messages, dependent: :delete_all
  has_many :albums, dependent: :destroy
  has_many :treatment_plan_files, dependent: :destroy

  validates :name, presence: true
  validates :start_date, presence: true
end
