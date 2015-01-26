class CreateModuleClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :claim_nr
      t.integer :relation_id
      t.integer :company_id

      t.timestamps
    end
    add_index :claims, :company_id
    add_index :claims, :relation_id

    add_column :subscriptions, :mod_claim, :boolean
    add_column :users, :mod_claim, :boolean
  end
end
