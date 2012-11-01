class RemoveLicensesFromSubscription < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :licenses
  end

  def down
    add_column :subscriptions, :licenses, :integer
  end
end
