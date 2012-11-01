class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :sign_in_count, :integer
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :company_id, :integer
  end
end
