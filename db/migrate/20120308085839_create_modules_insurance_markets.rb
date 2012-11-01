class CreateModulesInsuranceMarkets < ActiveRecord::Migration
  def change
    create_table :modules_insurance_markets do |t|
      t.string :market
      t.integer :company_id

      t.timestamps
    end
    add_index :modules_insurance_markets, :company_id
  end
end
