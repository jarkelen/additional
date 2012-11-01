class RenameInsuranceTable < ActiveRecord::Migration
  def up
    rename_table :modules_insurances, :insurances
    rename_table :modules_ins_branches, :ins_branches
    rename_table :modules_ins_types, :ins_types
    rename_table :modules_ins_markets, :ins_markets
  end

  def down
    rename_table :insurances, :modules_insurances
    rename_table :ins_branches, :modules_ins_branches
    rename_table :ins_types, :modules_ins_types
    rename_table :ins_markets, :modules_ins_markets
  end
end
