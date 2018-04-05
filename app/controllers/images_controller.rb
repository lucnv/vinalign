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
      unless current_user.admin?
        CreateUploadImagesNotification.new(current_user.user_profile, album, 1).perform
      end
    else
      @upload_success = false
      flash.now[:failed] = t ".failed"
    end
  end

  def destroy
    if params[:checked_params].present?
      Image.destroy(params[:checked_params].keys)
      @delete_success = true
      flash.now[:success] = t ".success"
    else
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
