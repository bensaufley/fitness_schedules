class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :client_id
      t.integer :trainer_id

      t.timestamps
    end
    add_index :relationships, :client_id
    add_index :relationships, :trainer_id
    add_index :relationships, [:client_id, :trainer_id], unique: true
  end
end
