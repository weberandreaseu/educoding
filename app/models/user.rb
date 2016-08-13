class User < ApplicationRecord
  has_secure_password
  has_many :solutions

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, uniqueness: true
end
