class ClinicManagement::AlbumsController < ClinicManagement::BaseController
  before_action :treatment_phase, only: [:new, :create]
  before_action :album, only: [:edit, :update, :destroy]

  def new
    @album = Album.new
  end

  def create
    @album = @treatment_phase.albums.build album_params
    if @album.save
      flash.now[:success] = t ".success"
      @albums = @treatment_phase.albums
    else
      flash.now[:failed] = t ".failed"
    end
  end

  def edit
  end

  def update
    @album.assign_attributes album_params
    if @album.save
      flash.now[:success] = t ".success"
    else
      flash.now[:failed] = t ".failed"
    end
  end

  def destroy
    if @album.destroy
      flash[:success] = t ".success"
    else
      flash[:failed] = t ".failed"
    end
    redirect_to clinic_management_treatment_phase_path(@album.treatment_phase, tab: :images)
  end

  private
  def album
    @album = Album.find params[:id]
  end

  def treatment_phase
    @treatment_phase = TreatmentPhase.find params[:treatment_phase_id]
  end

  def album_params
    params.require(:album).permit Album::ATTRIBUTES
  end
end
