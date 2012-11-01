class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :function
      t.string :telephone_business
      t.string :telephone_private
      t.string :telephone_mobile
      t.string :twitter
      t.string :facebook
      t.string :linkedin
      t.text :background
      t.integer :relation_id

      t.timestamps
    end
  end
end
