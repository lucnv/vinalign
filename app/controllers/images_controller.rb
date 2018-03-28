class ImagesController < ApplicationController
  before_action :album

  def index
    @images = @album.images
  end

  def create
    if @album.images.create image_params
      @upload_success = true
      @images = @album.images
      flash.now[:success] = t ".success"
      CreateUploadImagesNotification.new(album, 1).perform unless current_user.admin?
    else
      @upload_success = false
      flash.now[:failed] = t ".failed"
    end
  end

  private
  def image_params
    {source: params[:sources]}
  end

  def album
    @album = Album.find params[:album_id]
  end
end
