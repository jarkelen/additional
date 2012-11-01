class CreateModulesInsuranceInsurances < ActiveRecord::Migration
  def change
    create_table :modules_insurance_insurances do |t|
      t.string :insurance_nr
      t.string :branch
      t.string :insurance_type
      t.string :market
      t.datetime :start_date
      t.integer :duration
      t.datetime :first_contract_expiration_date
      t.datetime :main_premium_expiration_date
      t.string :extension
      t.string :payment_continuation
      t.string :arrear_calculation
      t.integer :relation_id

      t.timestamps
    end
    add_index :modules_insurance_insurances, :relation_id
  end
end
