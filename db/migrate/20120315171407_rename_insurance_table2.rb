class RenameInsuranceTable2 < ActiveRecord::Migration
  def up
    rename_table :insurances, :ins_insurances
  end

  def down
    rename_table :ins_insurances, :insurances
  end
end
