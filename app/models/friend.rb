class Friend
  include ActiveModel::Model

  attr_accessor :id
  attr_accessor :email
  validates_presence_of :email
end
