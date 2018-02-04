class Message < ApplicationRecord
  ATTRIBUTES = [:content]

  belongs_to :treatment_phase
  belongs_to :user_profile, foreign_key: :sender_id

  scope :earlier_created, ->{order created_at: :asc}
end
