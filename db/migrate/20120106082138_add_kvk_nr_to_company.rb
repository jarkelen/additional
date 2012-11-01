class AddKvkNrToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :kvk_nr, :integer
    add_column :companies, :bankaccount, :string
    add_column :companies, :billing_address, :string
    add_column :companies, :billing_zipcode, :string
    add_column :companies, :billing_city, :string
    add_column :companies, :billing_country, :string
    add_column :companies, :post_address, :string
    add_column :companies, :post_zipcode, :string
    add_column :companies, :post_city, :string
    add_column :companies, :post_country, :string
  end
end
