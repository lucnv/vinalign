class Message < ApplicationRecord
  belongs_to :treatment_phase
  belongs_to :user, foreign_key: :sender_id
end
