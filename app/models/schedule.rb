class Schedule < ActiveRecord::Base
  attr_accessible :rendered, :scheduled_date
  
  belongs_to :client
  
  validates :client_id, presence: true
  validates :scheduled_date, presence: true
  validates :scheduled_date, date: { after: Proc.new { Time.now } }, on: :create
end
