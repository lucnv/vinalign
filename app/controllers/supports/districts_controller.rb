class Supports::DistrictsController < ApplicationController
  def index
    @districts = Province.find(params[:object]).districts.name_asc.pluck :name, :id
  rescue
    []
  end
end
