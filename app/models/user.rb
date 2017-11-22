class User < ApplicationRecord
  attr_accessor :login
  
  validates :username, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.validations.user.username.max_length,
    minimum: Settings.validations.user.username.min_length}

  before_save :downcase_username

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, 
    :rememberable, :trackable, :validatable

  enum role: [:admin, :doctor]


  class << self
    def find_for_database_authentication warden_conditions
      conditions = warden_conditions.dup
      if login = conditions.delete(:login).try(:downcase)
        where(conditions.to_hash).where(username: login).or(User.where email: login).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
    end
  end

  private
  def downcase_username
    self.username.try :downcase!
  end
end
