class ApplicationController < ActionController::Base

private

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  helper_method :current_user

  def authorise
    redirect_to new_user_path, alert: "Not authorised!" if current_user.nil?
  end
end
