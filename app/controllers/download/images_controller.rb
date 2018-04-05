class Download::ImagesController < ApplicationController
  def show
    image = Image.find params[:id]
    file_name = File.basename image.source.path
    data = open(image.source.url)
    send_data data.read, filename: file_name, type: data.content_type, x_sendfile: true
  end
end
