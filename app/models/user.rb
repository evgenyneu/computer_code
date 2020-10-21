class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email
  validates_presence_of :email, :word
  before_create { generate_token(:auth_token) }
  before_save { self.email = email.downcase.strip }

  has_and_belongs_to_many :friendships,
                          class_name: "User",
                          join_table:  :friendships,
                          foreign_key: :user_id,
                          association_foreign_key: :friend_user_id

  def make_friends(friend)
    friendships << friend
    friend.friendships << self
  end

  def unfriend(friend)
    friendships.destroy(friend)
    friend.friendships.destroy(self)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
