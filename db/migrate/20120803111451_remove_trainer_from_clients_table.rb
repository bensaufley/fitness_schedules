class RemoveTrainerFromClientsTable < ActiveRecord::Migration
  def change
    remove_column :clients, :trainer_id
  end
end
