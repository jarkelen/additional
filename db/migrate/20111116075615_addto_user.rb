class AddtoUser < ActiveRecord::Migration
  def up
		add_column :users, :password_digest, :string
		add_column :users, :role, :string
  end

  def down
		remove_column :users, :password_digest
		remove_column :users, :role
  end
end
