class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ edit update destroy ]
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
    # current_album = Album.find params[:album_id]
    # @photo = Photo.new(album_id: current_album.id, user_id: current_album.user_id)
    # if @photo.save
    #   redirect_to edit_album_path(current_album), notice: "New photo added"
    # end

    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to '/u/photos', notice: "New photo added"
    else
      render :new, status: :unprocessable_entity, notice: "Something wrong!"
    end
    # @photo = @album.photos.create(photo_params)
    # @album = Album.find(params[:album_id])
    # redirect_to album_path(@album)
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      redirect_to '/u/photos', notice: "Photo was successfully updated."
    else
      redirect_to '/u/photos', notice: "Something wrong!"
    end
  end

  def destroy
    @photo.destroy!
    redirect_to '/u/photos', notice: "Photo was successfully destroyed."
  end

  private
  def photo_params
    params.require(:photo).permit(:album_id, :title, :description, :is_public)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def correct_user
    @photo = current_user.photos.find_by(id: params[:id])
    redirect_to photos_path, notice: "Not Authorized" if @photo.nil?
  end
end
