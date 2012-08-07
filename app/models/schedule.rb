class Schedule < ActiveRecord::Base
  attr_accessible :rendered, :scheduled_date, :trainer_id, :exercises_attributes
  
  belongs_to :client
  belongs_to :trainer
  has_many :exercises
  accepts_nested_attributes_for :exercises, allow_destroy: true
  
  validates :client_id, presence: true
  validates :trainer_id, presence: true
  validates :scheduled_date, presence: true
  validates :scheduled_date, date: { after: Proc.new { (Date.yesterday) } }, on: :create
  
end
