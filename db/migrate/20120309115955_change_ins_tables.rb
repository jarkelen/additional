class ChangeInsTables < ActiveRecord::Migration
  def self.up
      rename_table :modules_insurance_branches, :modules_ins_branches
      rename_table :modules_insurance_types, :modules_ins_types
      rename_table :modules_insurance_markets, :modules_ins_markets
  end 
  def self.down
    rename_table :modules_ins_branches, :modules_insurance_branches
    rename_table :modules_ins_types, :modules_insurance_types
    rename_table :modules_ins_markets, :modules_insurance_markets
  end
end
