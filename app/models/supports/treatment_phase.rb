class Supports::TreatmentPhase
  attr_reader :treatment_phase, :optional_params

  def initialize treatment_phase, optional_params = {}
    @treatment_phase = treatment_phase
    @optional_params = optional_params
  end

  def albums
    @albums ||= treatment_phase.albums.recent_updated
  end

  def messages
    @messages ||= treatment_phase.messages.earlier_created.includes :user_profile
  end

  def treatment_plan_files
    @treatment_plan_files ||= treatment_phase.treatment_plan_files.recent_created
  end

  def album
    @album ||= if optional_params[:album].present?
      albums.find optional_params[:album]
    else
      albums.first
    end
  end

  def album_images
    @first_album_images ||= if @album.present?
      @first_album.images
    else
      Image.none
    end
  end
end
