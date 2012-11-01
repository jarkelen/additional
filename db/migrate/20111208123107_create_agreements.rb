class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.string :agreement
      t.integer :user_id
      t.integer :contact_id

      t.timestamps
    end
  end
end
