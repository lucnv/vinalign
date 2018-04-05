class PatientRecord < ApplicationRecord
  include PgSearch

  ATTRIBUTES = [:start_date, :first_name, :last_name, :dob, :gender, :district_id,
    :address, :phone_number, :email, :doctor, :profile_photo, :status]

  belongs_to :clinic
  belongs_to :district, optional: true
  has_one :province, through: :district
  has_many :treatment_phases, dependent: :destroy
  has_many :price_lists, dependent: :delete_all
  has_many :notification, as: :notifiable, dependent: :destroy

  validates :start_date, presence: true
  validates :first_name, presence: true, length: {maximum: Settings.validations.patient_record.first_name.max_length}
  validates :last_name, presence: true, length: {maximum: Settings.validations.patient_record.last_name.max_length}
  validates :gender, presence: true
  validates :address, length: {maximum: Settings.validations.patient_record.address.max_length}
  validates :email, email_format: true
  validates :dob, presence: true

  scope :recent_created, ->{order created_at: :desc}
  scope :full_name_cont, ->(name) do
    where "LOWER(CONCAT(#{PatientRecord.table_name}.last_name, #{PatientRecord.table_name}.first_name)) \
      LIKE '%#{name.to_s.downcase}%'"
  end
  scope :start_date_from, ->(time) do
    time = Time.parse time.to_s
    where start_date: time.beginning_of_day..Time.zone.now
  end

  before_create :generate_public_token
  before_save :update_normalized_name
  before_destroy :clean_s3

  mount_uploader :profile_photo, AvatarUploader

  enum gender: Settings.genders.map(&:to_sym)

  delegate :id, :name, to: :province, prefix: true, allow_nil: true
  delegate :name, to: :clinic, prefix: true, allow_nil: true
  delegate :name, to: :district, prefix: true, allow_nil: true


  pg_search_scope :search_by_full_name, against: {first_name: "A", last_name: "A", normalized_name: "B"}

  ransacker :gender, formatter: proc {|value| genders[value]}

  def full_name
    last_name + " " + first_name
  end

  class << self
    def ransackable_scopes auth_object = nil
      [:full_name_cont, :start_date_from]
    end
  end

  private
  def clean_s3
    profile_photo.remove!
    profile_photo.medium.remove!
    profile_photo.small.remove!
  rescue Excon::Errors::Error => error
    puts error
    false
  end

  def update_normalized_name
    self.normalized_name = (self.first_name + " " + self.last_name).to_url.gsub "-", " "
  end

  def generate_public_token
    self.public_token = SecureRandom.base58 50
  end
end
