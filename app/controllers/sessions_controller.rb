class SessionsController < ApplicationController
  def new
    # Display the sign-in form
  end

  # session: {
  #   email:
  #   password
  # }
  def create
    user = User.find_by(email: params[:session][:email])

    # using bcrypt to authenticate
    # if user && user.authenticate(params[:session][:password])

    if user && (user.password == params[:session][:password])
      session[:email] = user.email
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

end
