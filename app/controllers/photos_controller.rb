class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @photos = Photo.public_mode
  end

  def user_photos
    sharing_mode = params[:mode]
    user_photos = current_user.photos
    if sharing_mode == 'public'
      @photos = user_photos.public_mode
    elsif sharing_mode == 'private'
      @photos = user_photos.private_mode
    else
      @photos = user_photos
    end
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to '/u/photos', notice: "New photo added"
    else
      render :new, status: :unprocessable_entity
    end
    # @photo = @album.photos.create(photo_params)
    # @album = Album.find(params[:album_id])
    # redirect_to album_path(@album)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :description, :is_public)
  end

  def correct_user
    @album = current_user.albums.find_by(id: params[:album_id])
    redirect_to albums_path, notice: "Not Authorized" if @album.nil?
  end
end
