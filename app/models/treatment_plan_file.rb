class TreatmentPlanFile < ApplicationRecord
  belongs_to :treatment_phase

  mount_uploader :source, OrthoFileUploader
end
