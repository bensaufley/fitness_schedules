class Schedule < ActiveRecord::Base
  attr_accessible :rendered, :scheduled_date, :exercises_attributes
  
  belongs_to :client
  
  has_many :exercises
  accepts_nested_attributes_for :exercises
  
  validates :client_id, presence: true
  validates :scheduled_date, presence: true
  validates :scheduled_date, date: { after: Proc.new { Time.now } }, on: :create
end
