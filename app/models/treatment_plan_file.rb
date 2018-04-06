class TreatmentPlanFile < ApplicationRecord
  belongs_to :treatment_phase
  has_many :notifications, as: :notifiable, dependent: :destroy

  scope :recent_created, ->{order created_at: :desc}

  enum doctor_opinion: [:not_yet, :agree, :disagree]

  mount_uploader :source, OrthoFileUploader

  delegate :full_name, to: :treatment_phase, allow_nil: true

  before_destroy :clean_s3

  def doctor_expressed?
    !not_yet?
  end

  private
  def clean_s3
    source.remove!
  rescue Excon::Errors::Error => error
    puts error
    false
  end
end
