class AddCompanyIdToModulesInsuranceInsurances < ActiveRecord::Migration
  def change
    add_column :modules_insurance_insurances, :company_id, :integer
    add_index :modules_insurance_insurances, :company_id
  end
end
