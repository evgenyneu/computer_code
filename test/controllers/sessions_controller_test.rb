require 'my_test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "login" do
    cookies[:auth_token] = nil
    user = create(:user, password: 'hello123', password_confirmation: 'hello123')

    post sessions_url, params: { email: user.email, password: 'hello123' }

    assert_redirected_to root_url
    assert_equal 'Logged in!', flash[:notice]
    assert cookies[:auth_token].present?
  end

  test "login fail" do
    cookies[:auth_token] = nil
    user = create(:user, password: 'hello123', password_confirmation: 'hello123')

    post sessions_url, params: { email: user.email, password: 'hEllo123' }

    assert_equal 'Email or password is invalid', flash[:alert]
    assert cookies[:auth_token].blank?
  end

  test "logout" do
    user = create(:user, password: 'hello123', password_confirmation: 'hello123')
    sign_in_as(user)

    delete session_url(user)

    assert_redirected_to root_url
    assert_equal 'Logged out!', flash[:notice]
    assert cookies[:auth_token].blank?
  end
end
