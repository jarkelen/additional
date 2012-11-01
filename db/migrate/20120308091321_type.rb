class Type < ActiveRecord::Migration
  def up
	  add_column :modules_insurance_types, :branch_id, :integer
	  add_index :modules_insurance_types, :branch_id
  end

  def down
	  remove_column :modules_insurance_types, :branch_id
  end
end
