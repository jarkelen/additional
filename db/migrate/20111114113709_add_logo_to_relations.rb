class AddLogoToRelations < ActiveRecord::Migration
  def change
    add_column :relations, :logo, :string
  end
end
