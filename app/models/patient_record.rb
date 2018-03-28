class PatientRecord < ApplicationRecord
  ATTRIBUTES = [:start_date, :first_name, :last_name, :dob, :gender, :district_id,
    :address, :phone_number, :email, :doctor, :profile_photo]

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

  mount_uploader :profile_photo, AvatarUploader

  enum gender: Settings.genders.map(&:to_sym)

  delegate :id, :name, to: :province, prefix: true, allow_nil: true
  delegate :name, to: :clinic, prefix: true, allow_nil: true
  delegate :name, to: :district, prefix: true, allow_nil: true


  before_destroy :clean_s3

  ransacker :gender, formatter: proc {|value| genders[value]}

  def full_name
    last_name + " " + first_name
  end

  class << self
    def ransackable_scopes auth_object = nil
      [:full_name_cont]
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
end
