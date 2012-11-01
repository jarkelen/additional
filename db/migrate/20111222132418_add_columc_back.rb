class AddColumcBack < ActiveRecord::Migration
  def up
    add_column :notes, :dossier_id, :integer
    add_column :tasks, :dossier_id, :integer
    add_column :agreements, :dossier_id, :integer
  end

  def down
    remove_column :notes, :dossier_id
    remove_column :tasks, :dossier_id
    remove_column :agreements, :dossier_id
  end
end
