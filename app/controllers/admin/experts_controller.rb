class Admin::ExpertsController < Admin::BaseController
  def index
    @q = Expert.ransack params[:q]
    @experts = @q.result.page(params[:page]).per(Settings.experts.per_page).decorate
    @support = Supports::Expert.new
  end
end
