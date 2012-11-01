class FormChanges < ActiveRecord::Migration
  def up
  	remove_column :relations, :billing_telephone
  	remove_column :relations, :billing_fax
  	remove_column :relations, :billing_email
  	remove_column :relations, :visit_telephone
  	remove_column :relations, :visit_fax
  	remove_column :relations, :visit_email
  	add_column :relations, :telephone, :string
  	add_column :relations, :fax, :string
  	add_column :relations, :email, :string
  end

  def down
  	add_column :relations, :billing_telephone, :string
  	add_column :relations, :billing_fax, :string
  	add_column :relations, :billing_email, :string
  	add_column :relations, :visit_telephone, :string
  	add_column :relations, :visit_fax, :string
  	add_column :relations, :visit_email, :string
  	remove_column :relations, :telephone
  	remove_column :relations, :fax
  	remove_column :relations, :email
  end
end

