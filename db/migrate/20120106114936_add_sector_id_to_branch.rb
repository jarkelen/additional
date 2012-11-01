class AddSectorIdToBranch < ActiveRecord::Migration
  def change
    add_column :branches, :sector_id, :integer
    remove_column :branches, :company_id
  end
end
