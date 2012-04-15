class ImagesController < ApplicationController
  respond_to :js, :json

  def create
    @album = Album.find_by_slug(params[:album_id])
    @image = @album.images.new(params[:image])
    authorize!(:create, @image)
    @image.save
    respond_with(@image, formats: :json)
  end

  def destroy
    @album = Album.find_by_slug(params[:album_id])
    @image = @album.images.find(params[:id])
    authorize!(:destroy, @image)

    @image.destroy
    respond_with(@image)
  end
end
