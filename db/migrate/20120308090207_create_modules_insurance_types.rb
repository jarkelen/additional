class CreateModulesInsuranceTypes < ActiveRecord::Migration
  def change
    create_table :modules_insurance_types do |t|
      t.string :type
      t.integer :company_id

      t.timestamps
    end
    add_index :modules_insurance_types, :company_id
  end
end
