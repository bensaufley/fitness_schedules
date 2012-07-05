class Exercise < ActiveRecord::Base
  attr_accessible :circuit, :name, :order, :reps_or_duration, :schedule_id, :weight_or_intensity
  
  belongs_to :schedule
  
  validates :name, presence: true
  validates :reps_or_duration, presence: true
  validates :schedule_id, presence: true
  validates :weight_or_intensity, presence: true
  
end
