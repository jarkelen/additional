class DeleteCompanyIdFromRelations < ActiveRecord::Migration
  def up
    remove_column :relations, :company_id
  end

  def down
    add_column :relations, :company_id, :string
  end
end
