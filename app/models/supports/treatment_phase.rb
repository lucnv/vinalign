class Supports::TreatmentPhase
  attr_reader :treatment_phase

  def initialize treatment_phase
    @treatment_phase = treatment_phase
  end

  def albums
    @albums ||= @treatment_phase.albums
  end
end
