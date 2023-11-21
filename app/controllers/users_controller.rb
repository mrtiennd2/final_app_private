class UsersController < ApplicationController
  layout 'profile_layout'

  before_action :authenticate_user!
  before_action :set_user, except: %i[index]

  def index; end

  def show; end

  def photos
    @photos =
      if current_user.id == @user.id
        @user.photos.where(album_id: nil)
      else
        @user.photos.where(album_id: nil).public_mode
      end
  end

  def albums
    @albums =
      if current_user.id == @user.id
        @user.albums
      else
        @user.albums.public_mode
      end
  end

  def follow
    @follower = Follower.where(user_id: @user.id, follower_id: current_user.id).first_or_initialize
    user_fname = @user.full_name
    if !@follower.persisted?
      if @follower.save
        redirect_to @user, notice: "Now following #{user_fname}"
      else
        redirect_to @user, notice: "Failed to follow #{user_fname}"
      end
    else
      @follower.destroy
      redirect_to @user, notice: "Unfollow #{user_fname}"
    end
  end

  def followers
    @followers = @user.followers
  end

  def followings
    @followings = @user.followings
  end

  private

  def set_user
    user_id = params[:id]
    @user = User.includes(:photos, :albums).find(user_id)
  end

end
