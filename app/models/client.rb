class Client < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :trainer_id
  has_secure_password
  belongs_to :trainer
  
  validates :name, presence: true, length: { maximum: 40 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }
	
	before_save { |client| client.email = email.downcase }
end
