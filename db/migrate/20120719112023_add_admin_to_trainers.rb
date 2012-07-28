class AddAdminToTrainers < ActiveRecord::Migration
  def change
    add_column :trainers, :admin, :boolean, default: false
  end
end
