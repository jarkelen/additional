class RemoveActivityTypeFromActivity < ActiveRecord::Migration
  def up
    remove_column :activities, :activity_type
  end

  def down
    add_column :activities, :activity_type, :string
  end
end
