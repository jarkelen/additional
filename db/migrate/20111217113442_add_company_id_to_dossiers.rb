class AddCompanyIdToDossiers < ActiveRecord::Migration
  def change
    add_column :dossiers, :company_id, :integer
  end
end
