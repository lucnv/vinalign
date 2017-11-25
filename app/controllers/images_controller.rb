class ImagesController < ApplicationController 
  before_action :album

  def index 
    @images = @album.images
  end

  def create
    if @album.images.create image_params  
      @upload_success = true
      @images = @album.images
    else
      upload_success = false
    end
  end

  private
  def image_params
    params[:sources].map{|source| {source: source}}
  end

  def album
    @album = Album.find params[:album_id]
  end
end
