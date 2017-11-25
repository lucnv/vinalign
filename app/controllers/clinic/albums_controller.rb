class Clinic::AlbumsController < Clinic::BaseController 
  before_action :treatment_phase

  def new
    @album = Album.new
  end

  def create
    @album = @treatment_phase.albums.build album_params
    if @album.save
      @albums = @treatment_phase.albums
    end
  end

  private
  def treatment_phase
    @treatment_phase = TreatmentPhase.find params[:treatment_phase_id]
  end

  def album_params
    params.require(:album).permit Album::ATTRIBUTES
  end
end
