class Client < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :schedules_attributes
  has_secure_password
  has_many :relationships
  has_many :trainers, through: :relationships
  has_many :schedules
  
  accepts_nested_attributes_for :schedules, allow_destroy: true
  
  validates :name, presence: true, length: { maximum: 40 }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, length: { minimum: 6 }, on: :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }, on: :create
	
	before_save { |client| client.email = email.downcase }
end
