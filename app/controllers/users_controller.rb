class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      cookies.permanent[:auth_token] = @user.auth_token
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to root_url, notice: "Profile updated"
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :word)
  end
end
