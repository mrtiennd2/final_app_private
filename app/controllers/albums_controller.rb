class AlbumsController < ApplicationController
  layout 'index_with_pagination', only: %i[index user_albums]

  before_action :set_album, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @albums = Album.includes(:photos, :likes).where(is_public: true).page(params[:page])
  end

  def user_albums
    @albums =
      if current_user.is_admin
        Album.all.page(params[:page])
      else
        current_user.albums.page(params[:page])
      end
  end

  def show; end

  def like
    album = Album.find(params[:album_id])
    @like = current_user.likes.find_by(likeable: album)
    if @like
      @like.destroy
      redirect_to albums_path, notice: 'Unliked'
    else
      current_user.likes.create(likeable: album)
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

    if params[:album][:photo_image].present?
      @album.photos_attributes = [{ user_id: current_user.id, image_url: params[:album][:photo_image] }]
    end

    if @album.save
      redirect_to edit_album_url(@album), notice: 'Album was successfully created.'
    else
      redirect_to new_album_url, notice: @album.errors.full_messages
    end
  end

  def update
    if params[:album][:photo_image].present?
      @album.photos_attributes = [{ user_id: current_user.id, image_url: params[:album][:photo_image] }]
    end

    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to edit_album_url(@album), notice: 'Album was successfully updated.' }
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

  # def built_photo
  #   photo_image = params[:album][:photo_image]
  #   photo_image && @album.photos.build(user_id: @album.user_id, is_public: @album.is_public, image_url: photo_image)
  # end

  def album_params
    params.require(:album).permit(:title, :description, :is_public)
  end

  def correct_user
    @album = current_user.albums.find_by(id: params[:id]) unless current_user.is_admin
    redirect_to albums_path, notice: 'Not Authorized' if @album.nil?
  end

  def set_index_layout
    if user_signed_in? == false
      if current_user.is_admin
        self.class.layout 'admin/main'
      else
        self.class.layout 'index_with_pagination'
      end
    else
      self.class.layout 'index_with_pagination'
    end
  end
end
