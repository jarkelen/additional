class RemoveDossierIdFromTables < ActiveRecord::Migration
  def up
    remove_column :contacts, :dossier_id
    remove_column :notes, :dossier_id
    remove_column :tasks, :dossier_id
    remove_column :agreements, :dossier_id
  end

  def down
    add_column :contacts, :dossier_id, :integer
    add_column :notes, :dossier_id, :integer
    add_column :tasks, :dossier_id, :integer
    add_column :agreements, :dossier_id, :integer
  end
end
