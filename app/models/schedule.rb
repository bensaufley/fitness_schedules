class Schedule < ActiveRecord::Base
  attr_accessible :rendered, :scheduled_date
  
  validates :scheduled_date, presence: true
  validates :scheduled_date, date: { after: Proc.new { Time.now } }, on: :create
end
