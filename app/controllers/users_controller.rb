class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    if user_params[:password] != user_params[:password_confirmation]
      flash.now[:alert] = "Password confirmation does not match the password"
      render 'new'
    else
      @user = User.new(user_params.except(:password_confirmation))
      if @user.save
        redirect_to '/signin', notice: 'Account created successfully!'
      else
        render 'new'
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
