class User < ApplicationRecord
  attr_accessor :login

  has_one :user_profile
  has_one :clinic, through: :user_profile
  has_many :messages, through: :user_profile

  ADMIN_PERSIT_PARAMS = [:email, :password, :password_confirmation, :username, user_profile_attributes: [:clinic_id]]

  accepts_nested_attributes_for :user_profile

  validates :username, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.validations.user.username.max_length,
    minimum: Settings.validations.user.username.min_length}

  scope :profile_full_name_cont, ->(name) do
    joins(:user_profile)
      .where "LOWER(CONCAT(#{UserProfile.table_name}.last_name, #{UserProfile.table_name}.first_name)) \
        LIKE '%#{name.to_s.downcase}%'"
  end

  before_save :downcase_username

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  enum role: [:admin, :doctor]

  delegate :avatar, to: :user_profile, allow_nil: true
  delegate :id, to: :clinic, allow_nil: true, prefix: true
  delegate :name, to: :clinic, allow_nil: true, prefix: true
  delegate :phone_number, to: :user_profile, allow_nil: true

  class << self
    def find_for_database_authentication warden_conditions
      conditions = warden_conditions.dup
      if login = conditions.delete(:login).try(:downcase)
        where(conditions.to_hash).where(username: login).or(User.where email: login).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
    end

    def ransackable_scopes auth_object = nil
      [:profile_full_name_cont]
    end
  end

  private
  def downcase_username
    self.username.try :downcase!
  end
end
