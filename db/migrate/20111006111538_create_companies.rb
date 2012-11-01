class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :zipcode
      t.string :city
      t.string :country
      t.string :email
      t.string :telephone
      t.string :twitter
      t.string :facebook
      t.string :linkedin

      t.timestamps
    end
  end
end
