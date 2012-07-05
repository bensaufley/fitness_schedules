class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.integer :circuit
      t.integer :order
      t.string :name
      t.string :weight_or_intensity
      t.string :reps_or_duration
      t.integer :schedule_id

      t.timestamps
    end
  end
end
