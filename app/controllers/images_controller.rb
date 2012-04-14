class ImagesController < ApplicationController
  respond_to :js, :json, :html

  def create
    @album = Album.find_by_slug(params[:album_id])
    @image = @album.images.new(params[:image])
    authorize!(:create, @image)
    @image.save
    render 'create', formats: :json
  end

  def destroy
    @album = Album.find_by_slug(params[:album_id])
    @image = @album.images.find(params[:id])
    authorize!(:destroy, @image)

    @image.destroy
    respond_with(@image)
  end
end
