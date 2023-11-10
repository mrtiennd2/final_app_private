class PhotosController < ApplicationController
  before_action :set_photo, only: %i[edit update destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @photos = Photo.public_mode.where(album_id: nil)
  end

  def user_photos
    sharing_mode = params[:mode]
    user_photos = current_user.photos.where(album_id: nil) # only get photos that don't exist in album

    @photos =
      if sharing_mode == 'public'
        user_photos.public_mode
      elsif sharing_mode == 'private'
        user_photos.private_mode
      else
        user_photos
      end
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to '/u/photos', notice: 'New photo added'
    else
      render :new, status: :unprocessable_entity, notice: 'Something wrong!'
    end
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      redirect_to '/u/photos', notice: 'Photo was successfully updated.'
    else
      redirect_to '/u/photos', notice: 'Something wrong!'
    end
  end

  def destroy
    @photo.destroy!
    redirect_to '/u/photos', notice: 'Photo was successfully destroyed.'
  end

  private

  def photo_params
    params.require(:photo).permit(:album_id, :title, :description, :is_public, :image_url)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def correct_user
    @photo = current_user.photos.find_by(id: params[:id])
    redirect_to photos_path, notice: 'Not Authorized' if @photo.nil?
  end
end
