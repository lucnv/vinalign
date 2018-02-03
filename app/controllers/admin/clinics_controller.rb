class Admin::ClinicsController < Admin::BaseController
  def index
    @q = Clinic.ransack params[:q]
    @clinics = @q.result.recent_created.page(params[:page]).per(Settings.clinics.per_page)
      .decorate
    @support = Supports::Clinic.new
  end
end
