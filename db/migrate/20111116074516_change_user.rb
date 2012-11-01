class ChangeUser < ActiveRecord::Migration
  def up
		remove_column :users, :encrypted_password
		remove_column :users, :reset_password_token
		remove_column :users, :reset_password_sent_at
		remove_column :users, :remember_created_at
		remove_column :users, :current_sign_in_at
		remove_column :users, :current_sign_in_ip
		remove_column :users, :last_sign_in_ip
		remove_column :users, :username
		remove_column :users, :admin
  end

  def down
		add_column :users, :encrypted_password, :string
		add_column :users, :reset_password_token, :string
		add_column :users, :reset_password_sent_at, :datetime
		add_column :users, :remember_created_at, :datetime
		add_column :users, :current_sign_in_at, :datetime
		add_column :users, :current_sign_in_ip, :string
		add_column :users, :last_sign_in_ip, :string
		add_column :users, :username, :string
		add_column :users, :admin, :string
  end
end
