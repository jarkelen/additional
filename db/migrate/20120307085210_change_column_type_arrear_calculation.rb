class ChangeColumnTypeArrearCalculation < ActiveRecord::Migration
  def up
	  change_column :modules_insurance_insurances, :arrear_calculation, :boolean
  end

  def down
	  change_column :modules_insurance_insurances, :arrear_calculation, :string
  end
end
