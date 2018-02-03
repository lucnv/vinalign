class Admin::ClinicsController < Admin::BaseController
  def index
    @q = Clinic.ransack params[:q]
    @clinics = @q.result.recent_created.page(params[:page]).per(Settings.clinics.per_page)
      .decorate
    @support = Supports::Clinic.new
  end

  def show
    @clinic = Clinic.find params[:id]
  end

  def new
    @clinic = Clinic.new
    @support = Supports::Clinic.new @clinic
  end

  def create
    @clinic = Clinic.new clinic_params
    if @clinic.save
      flash[:success] = t ".success"
      redirect_to admin_clinics_path
    else
      @support = Supports::Clinic.new @clinic
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  private
  def clinic_params
    params.require(:clinic).permit Clinic::ADMIN_PERSIT_PARAMS
  end
end
