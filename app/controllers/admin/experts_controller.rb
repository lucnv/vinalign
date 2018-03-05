class Admin::ExpertsController < Admin::BaseController
  def index
    @q = Expert.ransack params[:q]
    @experts = @q.result.priority_desc.page(params[:page]).per(Settings.experts.per_page).decorate
    @support = Supports::Expert.new
  end

  def new
    @expert = Expert.new
    support_for_expert
  end

  def create
    @expert = Expert.new expert_params
    if @expert.save
      flash[:success] = t ".success"
      redirect_to admin_experts_path
    else
      support_for_expert
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  private
  def expert_params
    params.require(:expert).permit Expert::ATTRIBUTES
  end

  def support_for_expert
    @support = Supports::Expert.new @expert
  end
end
