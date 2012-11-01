class DeleteType < ActiveRecord::Migration
  def up
    remove_column :relations, :type
  end

  def down
    add_column :relations, :type, :string
  end
end
