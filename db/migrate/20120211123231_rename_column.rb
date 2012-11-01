class RenameColumn < ActiveRecord::Migration
  def up
    rename_column :relations, :group, :relationgroup
  end

  def down
    rename_column :relations, :relationgroup, :group
  end
end
