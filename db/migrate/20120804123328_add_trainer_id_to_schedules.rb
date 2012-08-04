class AddTrainerIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :trainer_id, :integer
  end
end
