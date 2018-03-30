class UserProfile < ApplicationRecord
  belongs_to :user, dependent: :destroy, inverse_of: :user_profile
  belongs_to :clinic, optional: true
  has_many :messages, foreign_key: :sender_id
  has_many :received_notifications, class_name: Notification.name, foreign_key: :recipient_id

  accepts_nested_attributes_for :user

  ADMIN_PERSIT_PARAMS = [:avatar, :first_name, :last_name, :dob, :gender, :phone_number, user_attributes: [:id, :email, :password, :password_confirmation, :username]]

  validates :user, :first_name, :last_name, presence: true

  enum gender: Settings.genders.map(&:to_sym)

  delegate :doctor?, :username, :email, to: :user, allow_nil: true

  mount_uploader :avatar, AvatarUploader

  before_destroy :clean_s3

  def full_name
    last_name + " " + first_name
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
