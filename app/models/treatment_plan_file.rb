class TreatmentPlanFile < ApplicationRecord
  belongs_to :treatment_phase
  has_many :notifications, as: :notifiable

  mount_uploader :source, OrthoFileUploader

  delegate :full_name, to: :treatment_phase, allow_nil: true

  before_destroy :clean_s3

  private
  def clean_s3
    source.remove!
  rescue Excon::Errors::Error => error
    puts error
    false
  end
end
