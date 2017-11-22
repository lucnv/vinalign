class TreatmentPhase < ApplicationRecord
  has_many :messages
  has_many :albums
end
