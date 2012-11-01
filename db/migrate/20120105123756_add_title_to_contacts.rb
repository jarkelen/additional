class AddTitleToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :title, :string
    add_column :contacts, :birth_date, :date
  end
end
