class AddTaxNrToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :tax_nr, :string
  end
end
