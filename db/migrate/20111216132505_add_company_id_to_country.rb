class AddCompanyIdToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :company_id, :integer
  end
end
