class AddHasBossToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :has_boss, :integer
    add_column :contacts, :is_boss, :string
  end
end
