class AddColsToRelations < ActiveRecord::Migration
  def change
    add_column :relations, :branch, :string
    add_column :relations, :bankaccount, :string
    add_column :relations, :post_address, :string
    add_column :relations, :post_zipcode, :string
    add_column :relations, :post_city, :string
    add_column :relations, :post_country, :string
  end
end
