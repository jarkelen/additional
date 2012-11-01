class ChangeColumnNameOfTypes < ActiveRecord::Migration
  def up
		rename_column :modules_insurance_types, :type, :ins_type
  end

  def down
	  rename_column :modules_insurance_types, :ins_type, :type
  end
end
