class UserProfile < ApplicationRecord
  belongs_to :user

  enum gender: Settings.genders.map(&:to_sym)

  mount_uploader :avatar, AvatarUploader

  before_destroy :clean_s3

  def full_name
    last_name + " " +first_name
  end

  private
  def clean_s3
    avatar.remove!
    avatar.medium.remove!
    avatar.small.remove!
  rescue Excon::Errors::Error => error
    puts error
    false
  end
end
