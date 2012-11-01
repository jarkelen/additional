class CreateDossiersContactsJoinTable < ActiveRecord::Migration
  def up
    create_table :dossiers_contacts, :id => false do |t|
      t.integer :dossier_id
      t.integer :contact_id
    end
    remove_column :contacts, :dossier_id
  end

  def self.down
    drop_table :dossiers_contacts
    add_column :contacts, :dossier_id, :integer
  end
end
