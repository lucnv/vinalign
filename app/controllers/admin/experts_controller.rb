class Admin::ExpertsController < Admin::BaseController
  before_action :expert, except: [:index, :new, :create]

  def index
    search_params = params[:expert_search].try :permit, ExpertSearch::SEARCHABLE_ATTRIBUTES
    @expert_search = ExpertSearch.new search_params
    @experts = @expert_search.result.priority_desc.full_name_asc
      .page(params[:page]).per(Settings.experts.per_page).decorate
    @support = Supports::Expert.new
  end

  def show
    @expert = @expert.decorate
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

  def edit
    @expert = @expert.decorate
    support_for_expert
  end

  def update
    if @expert.update_attributes expert_params
      flash[:success] = t ".success"
      redirect_to admin_experts_path
    else
      support_for_expert
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @expert.destroy
      flash[:success] = t ".success"
    else
      flash[:success] = t ".failed"
    end
    redirect_back fallback_location: admin_root_path
  end

  private
  def expert_params
    params.require(:expert).permit Expert::ATTRIBUTES
  end

  def support_for_expert
    @support = Supports::Expert.new @expert
  end

  def expert
    @expert = Expert.find params[:id]
  end
end
