class TreatmentPlanFile < ApplicationRecord
  belongs_to :treatment_phase
  has_many :notifications, as: :notifiable, dependent: :destroy

  scope :recent_created, ->{order created_at: :desc}

  enum doctor_opinion: [:not_yet, :agree, :disagree]

  mount_uploader :source, OrthoFileUploader

  delegate :full_name, to: :treatment_phase, allow_nil: true

  before_save :update_source_details
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

  def update_source_details
    if source.present?
      self.assign_attributes file_name: source.file.filename, content_type: source.file.content_type,
        file_size: source.file.size
    end
  end
end
