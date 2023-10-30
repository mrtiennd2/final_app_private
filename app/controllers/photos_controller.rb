class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:create]

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @album = Album.find(params[:album_id])
    @photo = @album.photos.create(photo_params)
    redirect_to album_path(@album)
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :description)
  end

  def correct_user
    @album = current_user.albums.find_by(id: params[:album_id])
    redirect_to albums_path, notice: "Not Authorized" if @album.nil?
  end
end
