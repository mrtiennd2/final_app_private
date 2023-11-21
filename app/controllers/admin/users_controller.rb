class Admin::UsersController < ApplicationController
  layout 'index_with_pagination', only: %i[index user_photo]

  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.where.not(is_admin: true).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'Account updated'
    else
      redirect_to new_photo_path, status: :unprocessable_entity, notice: 'Something wrong!'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
