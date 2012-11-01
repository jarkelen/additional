class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.integer :licenses
      t.integer :discount
      t.datetime :start_date
      t.string :billing_period
      t.float :user_price
      t.boolean :active
      t.boolean :mod_time
      t.boolean :mod_contract
      t.boolean :mod_invoice

      t.timestamps
    end
  end
end
