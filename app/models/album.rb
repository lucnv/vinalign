class Album < ApplicationRecord
  belongs_to :treatment_phase
  has_many :images
end
