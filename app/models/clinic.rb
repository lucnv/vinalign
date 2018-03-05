class Clinic < ApplicationRecord
  belongs_to :district

  has_one :province, through: :district
  has_one :doctor, class_name: UserProfile.name, foreign_key: :clinic_id, dependent: :destroy
  has_many :patient_records, dependent: :destroy

  ADMIN_PERSIT_PARAMS = [:name, :phone_number, :district_id, :address]

  scope :recent_created, ->{order created_at: :desc}
  scope :has_no_doctor, -> do
    left_outer_joins(:doctor)
    .where user_profiles: {clinic_id: nil}
  end

  delegate :id, :name, to: :province, prefix: true, allow_nil: true
  delegate :name, to: :district, prefix: true, allow_nil: true

  validates :name, presence: true
  validates :district_id, presence: true
end
