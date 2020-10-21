require 'my_test_helper'

class UserTest < ActiveSupport::TestCase
  test 'Create user' do
    user = create(:user, email: ' mY@seRver.com  ')

    assert user.persisted?
    assert user.auth_token.present?
    assert_equal 'my@server.com', user.email
  end

  test 'Make friends' do
    user1 = create(:user)
    user2 = create(:user)

    assert user1.friendships.empty?
    assert user2.friendships.empty?

    user1.make_friends(user2)

    assert_equal 1, user1.friendships.count
    assert_equal user2, user1.friendships[0]
    assert_equal 1, user2.friendships.count
    assert_equal user1, user2.friendships[0]
  end

  test 'Cant make friends with oneself' do
    user = create(:user)

    assert_raises(ActiveRecord::RecordNotUnique) do
      user.make_friends(user)
    end
  end

  test 'Unfriend' do
    user1 = create(:user)
    user2 = create(:user)

    user1.make_friends(user2)

    user1.unfriend(user2)

    assert_equal 0, user1.friendships.count
    assert_equal 0, user2.friendships.count
  end
end
