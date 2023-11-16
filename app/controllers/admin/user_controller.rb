class Admin::UserController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def edit
    @user = User.find(params[:id])
  end

  def update
    puts params
    if @user.update(user_params)
      redirect_to '/admin/dashboard', notice: 'Account updated'
    else
      redirect_to new_photo_path, status: :unprocessable_entity, notice: 'Something wrong!'
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
