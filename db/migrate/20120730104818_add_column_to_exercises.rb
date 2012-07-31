class AddColumnToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :comments, :string
  end
end
