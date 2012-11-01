class RenameBranchesColumn < ActiveRecord::Migration
  def up
    rename_column :modules_ins_types, :branch_id, :ins_branch_id
  end

  def down
    rename_column :modules_ins_types, :ins_branch_id, :branch_id
  end
end
