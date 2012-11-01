class ChangeType < ActiveRecord::Migration
  def up
    remove_column :activities, :type
    add_column :activities, :activity_type, :string
  end

  def down
    add_column :activities, :type, :string
    remove_column :activities, :activity_type
  end
end
