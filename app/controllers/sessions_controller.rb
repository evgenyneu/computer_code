class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email].downcase().strip
    user = User.find_by_email(email)

    if user && user.authenticate(params[:password])
      cookies.permanent[:auth_token] = user.auth_token
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now.alert = 'Email or password is invalid'
      render 'new'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, notice: 'Logged out!'
  end
end
