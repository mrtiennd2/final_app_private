class AlbumsController < ApplicationController
  layout 'index_with_pagination', only: %i[index user_albums]

  before_action :set_album, only: %i[edit update destroy like]
  before_action :authenticate_user!, except: %i[index]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @albums = Album.includes(:photos, :likes).where(is_public: true).page(params[:page])
  end

  def user_albums
    @albums =
      if current_user.is_admin
        Album.all.page(params[:page])
      else
        default_n_per_page = 10
        current_user.albums.page(params[:page]).per(default_n_per_page)
      end
  end

  def like
    @like = current_user.likes.find_by(likeable: @album)
    if @like
      @like.destroy
      redirect_to albums_path, notice: 'Unliked'
    else
      current_user.likes.create(likeable: @album)
      redirect_to albums_path(locale: I18n.locale), notice: 'Liked'
    end
  end

  def new
    @album = current_user.albums.build
  end

  def edit
    redirect_to :show if correct_user && correct_user.id == @album.user_id
  end

  def create
    @album = current_user.albums.build(album_params)
    @album.photos_attributes = attached_photos

    if @album.save
      redirect_to edit_album_path(@album), notice: 'Album was successfully created.'
    else
      render new_album_path, status: :unprocessable_entity, notice: @album.errors.full_messages
    end
  end

  def update
    @album.photos_attributes = attached_photos
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to edit_album_path(@album), notice: 'Album was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity, notice: 'Failed to save album' }
      end
    end
  end

  def destroy
    @album.destroy!

    respond_to do |format|
      format.html { redirect_to albums_path, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_album
    @album = Album.find(params[:id] || params[:album_id])
  end

  def attached_photos
    if params[:album][:photo_images].present?
      images = []
      params[:album][:photo_images].each do |image|
        next if image.blank?

        item = { user_id: current_user.id, image_url: image }
        images << item
      end
    end
    images
  end

  def album_params
    params.require(:album).permit(:title, :description, :is_public)
  end

  def correct_user
    @album = current_user.albums.find_by(id: params[:id]) unless current_user.is_admin
    redirect_to albums_path, notice: 'Not Authorized' if @album.nil?
  end
end
