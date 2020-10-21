require 'my_test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "Create user" do
    cookies[:auth_token] = nil

    assert_difference('User.count') do
      user_attr = attributes_for(:user)
      post users_url, params: { user: user_attr }
    end

    assert_redirected_to root_url
    assert_equal 'Thank you for signing up!', flash[:notice]
    assert cookies[:auth_token].present?
  end

  test "Update user" do
    user = create(:user)
    patch user_url(user), params: { id: user.id, user: { email: ' neW@email.com' } }

    user.reload

    assert_equal 'new@email.com', user.email
    assert_redirected_to root_url
    assert_equal 'Profile updated', flash[:notice]
  end
end
