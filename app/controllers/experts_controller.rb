class ExpertsController < ApplicationController
  def index
    @q = Expert.ransack params[:q]
    @experts = @q.result.priority_desc.page(params[:page]).per(Settings.front.experts.per_page).decorate
    @support = Supports::Expert.new
  end
end
