class AddModPlatformToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mod_platform, :boolean, :default => true
  end
end
