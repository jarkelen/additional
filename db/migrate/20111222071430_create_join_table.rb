class CreateJoinTable < ActiveRecord::Migration
  def up
    create_table :contacts_dossiers, :id => false do |t|
      t.integer :dossier_id
      t.integer :contact_id
    end
  end

  def self.down
    drop_table :contacts_dossiers
  end
end

