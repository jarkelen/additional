class AddCustomLabel1ToRelation < ActiveRecord::Migration
  def change
    add_column :relations, :custom_label_1, :string
    add_column :relations, :custom_field_1, :string
    add_column :relations, :custom_label_2, :string
    add_column :relations, :custom_field_2, :string
    add_column :relations, :custom_label_3, :string
    add_column :relations, :custom_field_3, :string
  end
end
