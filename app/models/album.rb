class Album < ApplicationRecord
  ATTRIBUTES = [:name]
  
  belongs_to :treatment_phase
  has_many :images

  validates :name, presence: true
end
