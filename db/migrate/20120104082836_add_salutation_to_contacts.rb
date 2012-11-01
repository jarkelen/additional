class AddSalutationToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :salutation, :string
    add_column :contacts, :gender, :string
  end
end
