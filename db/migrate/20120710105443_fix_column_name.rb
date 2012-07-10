class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :exercises, :order, :ex_order
  end

  def down
    rename_column :exercises, :ex_order, :order
  end
end
