class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :password_digest
      t.string :pincode_digest

      t.timestamps
    end
  end
end
