class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.date :scheduled_date
      t.boolean :rendered

      t.timestamps
    end
  end
end
