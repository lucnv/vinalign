class Clinic < ApplicationRecord
  include PgSearch

  belongs_to :district

  has_one :province, through: :district
  has_one :doctor, class_name: UserProfile.name, foreign_key: :clinic_id, dependent: :destroy
  has_one :user, through: :doctor
  has_many :patient_records, dependent: :destroy

  accepts_nested_attributes_for :doctor

  ADMIN_PERSIT_PARAMS = [:name, :phone_number, :district_id, :address, doctor_attributes: [:id, :avatar, :first_name, :last_name, :dob, :gender, :phone_number, user_attributes: [:id, :email, :password, :password_confirmation, :username, :role]]]

  scope :recent_created, ->{order created_at: :desc}
  scope :has_no_doctor, -> do
    left_outer_joins(:doctor)
    .where user_profiles: {clinic_id: nil}
  end

  before_save :update_normalized_fields

  delegate :id, :name, to: :province, prefix: true, allow_nil: true
  delegate :name, to: :district, prefix: true, allow_nil: true
  delegate :full_name, to: :doctor, prefix: true, allow_nil: true

  validates :name, presence: true
  validates :district_id, presence: true
  validates :address, presence: true

  pg_search_scope :search_by_name, against: {name: "A", normalized_name: "B"}

  def full_address
    [address, district_name, province_name].compact.join ", "
  end

  private
  def update_normalized_fields
    self.normalized_name = self.name.to_url.gsub "-", " "
  end
end
