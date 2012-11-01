class RemoveIsBossFromContact < ActiveRecord::Migration
  def up
    remove_column :contacts, :is_boss
  end

  def down
    add_column :contacts, :is_boss, :string
  end
end
