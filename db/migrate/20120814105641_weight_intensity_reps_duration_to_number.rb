class WeightIntensityRepsDurationToNumber < ActiveRecord::Migration
  def change
    change_column :exercises, :reps_or_duration, :decimal
    change_column :exercises, :weight_or_intensity, :decimal
  end
end
