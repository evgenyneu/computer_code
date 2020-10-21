require 'my_test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  test "Make friends" do
    user = create(:user)
    sign_in_as(user)

    friend = create(:user)
    post friends_url, params: { friend: {email: friend.email} }

    assert_redirected_to friends_path
    assert flash[:alert].blank?

    assert_equal 1, user.friendships.count
    assert_equal friend, user.friendships[0]
    assert_equal 1, friend.friendships.count
    assert_equal user, friend.friendships[0]
  end

  test "Cant be friends with yourself" do
    user = create(:user)
    sign_in_as(user)

    post friends_url, params: { friend: {email: user.email} }

    assert_equal 'You can not friend yourself', flash[:alert]
  end

  test "Friend does not exist" do
    user = create(:user)
    sign_in_as(user)

    post friends_url, params: { friend: {email: 'not found'} }

    assert_equal 'User does not exist', flash[:alert]
  end

  test "Blank email" do
    user = create(:user)
    sign_in_as(user)

    post friends_url, params: { friend: {email: ''} }

    assert_equal 'Please enter email', flash[:alert]
  end

  test "Unfriend email" do
    user = create(:user)
    sign_in_as(user)

    friend = create(:user)
    user.make_friends(friend)

    delete friend_url(friend)

    assert_redirected_to friends_path
    assert_equal 0, user.friendships.count
    assert_equal 0, friend.friendships.count
  end
end
