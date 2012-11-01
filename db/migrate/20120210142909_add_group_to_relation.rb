class AddGroupToRelation < ActiveRecord::Migration
  def change
    add_column :relations, :group, :string
  end
end
