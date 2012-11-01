class ChangeInsuranceTable < ActiveRecord::Migration
  def up
    rename_table :modules_insurance_insurances, :modules_insurances
  end

  def down
    rename_table :modules_insurances, :modules_insurance_insurances
  end
end
