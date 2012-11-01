class AddPositionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :position, :string
    add_column :users, :department, :string
  end
end
