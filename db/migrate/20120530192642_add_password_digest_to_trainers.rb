class AddPasswordDigestToTrainers < ActiveRecord::Migration
  def change
    add_column :trainers, :password_digest, :string
  end
end
