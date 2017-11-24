class PatientRecord < ApplicationRecord
  ATTRIBUTES = [:start_date, :first_name, :last_name, :dob, :gender, :district_id,
    :address, :phone_number, :email, :doctor, :profile_photo]

  belongs_to :clinic
  belongs_to :district
  has_one :province, through: :district
  has_many :treatment_phases
  has_many :price_lists

  validates :start_date, presence: true
  validates :first_name, presence: true, length: {maximum: Settings.validations.patient_record.first_name.max_length}
  validates :last_name, presence: true, length: {maximum: Settings.validations.patient_record.last_name.max_length}
  validates :dob, presence: true
  validates :gender, presence: true
  validates :district_id, presence: true
  validates :address, presence: true, length: {maximum: Settings.validations.patient_record.address.max_length}
  validates :email, email_format: true
  validates :doctor, presence: true

  scope :recent_created, ->{order created_at: :desc}

  mount_uploader :profile_photo, AvatarUploader

  enum gender: Settings.genders.map(&:to_sym)

  delegate :id, :name, to: :province, prefix: true, allow_nil: true
  delegate :name, to: :clinic, prefix: true, allow_nil: true
  delegate :name, to: :district, prefix: true, allow_nil: true
end
