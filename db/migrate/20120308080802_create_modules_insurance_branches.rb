class CreateModulesInsuranceBranches < ActiveRecord::Migration
  def change
    create_table :modules_insurance_branches do |t|
      t.string :branch
      t.integer :company_id

      t.timestamps
    end
    add_index :modules_insurance_branches, :company_id
  end
end
