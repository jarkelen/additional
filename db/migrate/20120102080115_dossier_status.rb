class DossierStatus < ActiveRecord::Migration
  def up
    remove_column :dossier_statuses, :status_nl
    remove_column :dossier_statuses, :status_en
    add_column :dossier_statuses, :status, :string
  end

  def down
    add_column :dossier_statuses, :status_nl, :string
    add_column :dossier_statuses, :status_en, :string
    remove_column :dossier_statuses, :status
  end
end
