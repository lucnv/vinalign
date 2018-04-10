class Album < ApplicationRecord
  ATTRIBUTES = [:name, :end_date]

  belongs_to :treatment_phase
  has_many :images, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  scope :recent_end_date, ->{order(end_date: :desc, updated_at: :desc)}

  validates :name, presence: true, uniqueness: {scope: :treatment_phase_id}
  validates :end_date, presence: true
  validates_length_of :images, maximum: Settings.album.max_images
end
