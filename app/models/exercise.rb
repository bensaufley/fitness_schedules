class Exercise < ActiveRecord::Base
  attr_accessible :circuit, :name, :ex_order, :reps_or_duration, :schedule_id, :weight_or_intensity, :comments
  
  belongs_to :schedule
  
  validates :name, presence: true
  validates :schedule_id, presence: true
  validates :weight_or_intensity, numericality: true, allow_blank: true
  validates :reps_or_duration, numericality: true, allow_blank: true
  
end
