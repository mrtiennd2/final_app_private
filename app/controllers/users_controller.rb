class UsersController < ApplicationController
  layout 'profile_layout', only: %i[show albums photos]

  before_action :authenticate_user!
  before_action :set_user, except: %i[index]

  def index; end

  def show; end

  def photos
    @photos = @user.photos
  end

  def albums
    @albums = @user.albums.includes(:photos)
  end

  def follow
    # ...
  end

  def unfollow
    # ...
  end

  def followers
    @followers = @user.follwers
  end

  def followings
    @following = @user.followings
  end

  private

  def user_params
    puts '...'
  end

  def set_user
    user_id = params[:id] || params[:user_id]
    @user = User.includes(:photos, :albums).find(user_id)
  end
end
