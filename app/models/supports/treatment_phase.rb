class Supports::TreatmentPhase
  attr_reader :treatment_phase

  def initialize treatment_phase
    @treatment_phase = treatment_phase
  end

  def albums
    @albums ||= treatment_phase.albums
  end

  def messages
    @messages ||= treatment_phase.messages.earlier_created.includes :user_profile
  end

  def treatment_plan_files
    @treatment_plan_files ||= treatment_phase.treatment_plan_files
  end
end
