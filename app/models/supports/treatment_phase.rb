class Supports::TreatmentPhase
  attr_reader :treatment_phase

  def initialize treatment_phase
    @treatment_phase = treatment_phase
  end

  def albums
    @albums ||= @treatment_phase.albums
  end

  def messages
    @messages ||= @treatment_phase.messages.earlier_created.includes user: :user_profile
  end
end
