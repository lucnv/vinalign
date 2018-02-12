class Album < ApplicationRecord
  ATTRIBUTES = [:name]

  belongs_to :treatment_phase
  has_many :images, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :name, presence: true, uniqueness: {scope: :treatment_phase_id}
end
