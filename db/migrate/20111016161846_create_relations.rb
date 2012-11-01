class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.string :relation_nr
      t.string :name
      t.string :type
      t.string :company_contact
      t.string :website
      t.integer :kvk_nr
      t.string :industry
      t.string :legal
      t.integer :nr_employees
      t.string :facebook
      t.string :twitter
      t.string :linkedin
      t.string :billing_address
      t.string :billing_zipcode
      t.string :billing_city
      t.string :billing_country
      t.integer :billing_telephone
      t.integer :billing_fax
      t.string :billing_email
      t.string :visit_address
      t.string :visit_zipcode
      t.string :visit_zipcode
      t.string :visit_city
      t.string :visit_country
      t.integer :visit_telephone
      t.integer :visit_fax
      t.string :visit_email
      t.text :remarks
      t.integer :company_id

      t.timestamps
    end
  end
end
