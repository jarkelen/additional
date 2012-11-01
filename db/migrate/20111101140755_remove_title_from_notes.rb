class RemoveTitleFromNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :title
  end
end
