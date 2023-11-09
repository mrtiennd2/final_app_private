class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @albums = Album.where(is_public: true)
  end

  def show
  end

  def new
    @album = current_user.albums.build
  end

  def user_albums
    @albums = current_user.albums
  end

  # GET /albums/1/edit
  def edit
    if correct_user && correct_user.id = @album.user_id
      redirect_to :show
    end
  end

  def create
    @album = current_user.albums.build(album_params)
    if @album.save
      redirect_to '/u/albums', notice: "Album was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        # format.html { redirect_to album_url(@album), notice: "Album was successfully updated." }
        format.html { redirect_to '/u/albums', notice: "Album was successfully updated." }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album.destroy!

    respond_to do |format|
      format.html { redirect_to albums_url, notice: "Album was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :description, :is_public)
  end

  def correct_user
    @album = current_user.albums.find_by(id: params[:id])
    redirect_to albums_path, notice: "Not Authorized" if @album.nil?
  end

end
