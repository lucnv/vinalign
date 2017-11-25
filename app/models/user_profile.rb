class UserProfile < ApplicationRecord
  belongs_to :user

  enum gender: Settings.genders.map(&:to_sym)

  mount_uploader :avatar, AvatarUploader
end
