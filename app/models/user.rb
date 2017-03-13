class User < ApplicationRecord

	before_save { self.email = email.downcase }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, :email, presence: true
	validates :email, length: { maximum: 50 }
	validates :email, format: { with: VALID_EMAIL_REGEX }
	validates :email, :uniqueness => true
	validates :password, length: { minimum: 6 }

	has_secure_password
end
