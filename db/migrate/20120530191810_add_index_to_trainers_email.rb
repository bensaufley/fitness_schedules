class AddIndexToTrainersEmail < ActiveRecord::Migration
  def change
    add_index :trainers, :email, unique: true
  end
end
