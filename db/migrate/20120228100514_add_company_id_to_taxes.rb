class AddCompanyIdToTaxes < ActiveRecord::Migration
  def change
    add_column :taxes, :company_id, :integer
  end
end
