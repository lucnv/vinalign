class ExpertsController < ApplicationController
  def index
    search_params = params[:expert_search].try :permit, ExpertSearch::SEARCHABLE_ATTRIBUTES
    @expert_search = ExpertSearch.new search_params
    @experts = @expert_search.result.priority_sort.full_name_asc
      .page(params[:page]).per(Settings.front.experts.per_page).decorate
    @support = Supports::Expert.new
  end
end
