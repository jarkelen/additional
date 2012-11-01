class AddColumnsForRelation < ActiveRecord::Migration
  def up
		add_column :relations, :latitude, :float #you can change the name, see wiki
		add_column :relations, :longitude, :float #you can change the name, see wiki
		add_column :relations, :gmaps, :boolean #not mandatory, see wiki
  end

  def down
		remove_column :relations, :latitude
		remove_column :relations, :longitude
		remove_column :relations, :gmaps
  end
end
