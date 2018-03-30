class Admin::ClinicsController < Admin::BaseController
  before_action :clinic, except: [:index, :new, :create]
  before_action :allow_without_password, only: [:update]

  def index
    search_params = params[:clinic_search].try :permit, ClinicSearch::SEARCHABLE_ATTRIBUTES
    @clinic_search = ClinicSearch.new search_params
    @clinics = @clinic_search.result.recent_created.page(params[:page]).per(Settings.clinics.per_page)
      .decorate
    @support = Supports::Clinic.new
  end

  def show
    @clinic = @clinic.decorate
  end

  def new
    @clinic = Clinic.new
    @clinic.build_doctor
    @clinic.build_doctor.build_user
    support_for_clinic
  end

  def create
    @clinic = Clinic.new clinic_params
    if @clinic.save
      flash[:success] = t ".success"
      redirect_to admin_clinics_path
    else
      support_for_clinic
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  def edit
    @clinic = @clinic.decorate
    support_for_clinic
  end

  def update
    if @clinic.update_attributes clinic_params
      flash[:success] = t ".success"
      redirect_to admin_clinics_path
    else
      support_for_clinic
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @clinic.destroy
      flash[:success] = t ".success"
    else
      flash[:success] = t ".failed"
    end
    redirect_back fallback_location: admin_root_path
  end

  private
  def clinic_params
    params.require(:clinic).permit(Clinic::ADMIN_PERSIT_PARAMS).merge(clinic: {doctor_attributes: {user_attributes: {role: :doctor}}})
  end

  def clinic
    @clinic = Clinic.find params[:id]
  end

  def support_for_clinic
    @support = Supports::Clinic.new @clinic
  end

  def allow_without_password
    user = params[:clinic][:doctor_attributes][:user_attributes]
    if user[:password].blank? && user[:password_confirmation].blank?
      user.delete(:password)
      user.delete(:password_confirmation)
    end
  end
end
