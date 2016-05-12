class User < ActiveRecord::Base
  has_secure_password

  validates :firstname, presence: true

  validates :lastname, presence: true

  validates :email, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, uniqueness: true
end
