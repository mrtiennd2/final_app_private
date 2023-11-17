class PhotosController < ApplicationController
  layout 'index_with_pagination', only: %i[index user_photos]

  before_action :set_photo, only: %i[edit update destroy]
  before_action :authenticate_user!, except: %i[index]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @photos = Photo.public_mode.where(album_id: nil).page(params[:page])
  end

  def user_photos
    @photos =
      if current_user.is_admin
        Photo.where(album_id: nil).page(params[:page])
      else
        current_user.photos.page(params[:page])
      end
  end

  def new
    @photo = current_user.photos.build
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to '/u/photos', notice: 'New photo added'
    else
      render new_photo_path, status: :unprocessable_entity, notice: 'Something wrong!'
    end
  end

  def edit
    redirect_to :index if correct_user && correct_user.id == @album.user_id
  end

  def update
    if @photo.update(photo_params)
      redirect_to '/u/photos', notice: 'Photo was successfully updated.'
    else
      redirect_to edit_photo_path, notice: 'Something wrong!'
    end
  end

  def like
    photo = Photo.find(params[:photo_id])
    like = current_user.likes.find_by(likeable: photo)
    if like
      like.destroy
      redirect_to photos_path, notice: 'Unliked'
    else
      current_user.likes.create(likeable: photo)
      redirect_to photos_path(locale: I18n.locale), notice: 'Liked'
    end
  end

  def destroy
    @photo.destroy!
    if @photo.album_id
      redirect_to edit_album_path(@photo.album_id)
    else
      redirect_to '/u/photos', notice: 'Photo was successfully destroyed.'
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:album_id, :title, :description, :is_public, :image_url)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def correct_user
    @photo = current_user.photos.find_by(id: params[:id]) unless current_user.is_admin
    redirect_to photos_path, notice: 'Not Authorized' if @photo.nil?
  end
end
