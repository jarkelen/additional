class AddCompanyIdToRelations < ActiveRecord::Migration
  def change
    add_column :relations, :company_id, :integer
  end
end
