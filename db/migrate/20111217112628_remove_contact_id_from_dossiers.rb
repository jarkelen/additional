class RemoveContactIdFromDossiers < ActiveRecord::Migration
  def up
    remove_column :dossiers, :contact_id
  end

  def down
    add_column :dossiers, :contact_id, :integer
  end
end
