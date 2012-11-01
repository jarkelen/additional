class DeleteColumnFromSites < ActiveRecord::Migration
  def up
    remove_column :sites, :pincode_digest
    add_column :sites, :pincode, :string
  end

  def down
    add_column :sites, :pincode_digest, :string
    remove_column :sites, :pincode
  end
end
