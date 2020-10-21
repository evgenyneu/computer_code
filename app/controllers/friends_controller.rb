class FriendsController < ApplicationController
  before_action :authorise

  def index
  end

  def new
    @friend = Friend.new
  end

  def create
    friend_email = params[:friend][:email]

    if friend_email.blank?
      flash.now.alert = 'Please enter email'
      render 'new'
      return
    end

    user = User.find_by_email(friend_email)

    if user.nil?
      flash.now.alert = 'User does not exist'
      render 'new'
      return
    end

    if user == current_user
      flash.now.alert = "You can not friend yourself"
      render 'new'
      return
    end

    current_user.make_friends(user)
    redirect_to friends_path
  rescue ActiveRecord::RecordNotUnique
    flash.now.alert = "User #{@friend.email} is already your friend"
    render 'new'
  end

  def destroy
    friend = current_user.friendships.find(params[:id])
    current_user.friendships.destroy(friend)
    friend.friendships.destroy(current_user)

    redirect_to friends_path
  end

  private

  def friend_params
    params.require(:friend).permit(:email)
  end
end
