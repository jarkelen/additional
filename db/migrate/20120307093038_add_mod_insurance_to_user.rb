class AddModInsuranceToUser < ActiveRecord::Migration
  def change
    add_column :users, :mod_insurance, :boolean
  end
end
