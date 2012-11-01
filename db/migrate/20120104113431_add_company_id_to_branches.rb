class AddCompanyIdToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :company_id, :integer
    remove_column :branches, :relation_id
  end
end
