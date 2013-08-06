class CreateInsInsurers < ActiveRecord::Migration
  def change
    create_table :ins_insurers do |t|
      t.string :insurer
      t.integer :company_id

      t.timestamps
    end
  end
end
