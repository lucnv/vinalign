class DoctorProfile < ApplicationRecord
  belongs_to :user
  belongs_to :clinic

  enum gender: Settings.genders.map(&:to_sym)
end
