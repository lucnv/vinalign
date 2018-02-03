class Clinic < ApplicationRecord
  belongs_to :district
  belongs_to :user
  has_one :province, through: :district
  has_many :patient_records

  scope :recent_created, ->{order created_at: :desc}

  delegate :id, :name, to: :province, prefix: true, allow_nil: true
  delegate :name, to: :district, prefix: true, allow_nil: true
end
