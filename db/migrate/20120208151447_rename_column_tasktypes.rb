class RenameColumnTasktypes < ActiveRecord::Migration
  def up
    rename_column :tasktypes, :type, :tasktype
  end

  def down
    rename_column :tasktypes, :tasktype, :type
  end
end
