class AlbumsController < ApplicationController
  layout 'index_with_pagination', only: %i[index]

  before_action :set_album, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @albums = Album.where(is_public: true).page(params[:page])
  end

  def user_albums
    @albums = current_user.albums.page(params[:page])
  end

  def show
  end

  def new
    @album = current_user.albums.build
  end

  def edit
    redirect_to :show if correct_user && correct_user.id == @album.user_id
  end

  def create
    @album = current_user.albums.build(album_params)
    if @album.save
      notice_msg = built_photo && !built_photo.save ? 'Failed to save image' : 'Album was successfully created.'
      redirect_to edit_album_url(@album), notice: notice_msg
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        notice_msg = built_photo && !built_photo.save ? 'Failed to save image' : 'Album was successfully updated.'
        format.html { redirect_to edit_album_url(@album), notice: notice_msg }
      else
        format.html { render :edit, status: :unprocessable_entity, notice: 'Failed to save album' }
      end
    end
  end

  def destroy
    @album.destroy!

    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def built_photo
    photo_image = params[:album][:photo_image]
    photo_image && @album.photos.build(user_id: @album.user_id, is_public: @album.is_public, image_url: photo_image)
  end

  def album_params
    params.require(:album).permit(:title, :description, :is_public)
  end

  def correct_user
    @album = current_user.albums.find_by(id: params[:id])
    redirect_to albums_path, notice: 'Not Authorized' if @album.nil?
  end
end
