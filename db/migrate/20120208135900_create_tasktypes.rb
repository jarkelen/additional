class CreateTasktypes < ActiveRecord::Migration
  def change
    create_table :tasktypes do |t|
      t.string :type
      t.integer :company_id

      t.timestamps
    end
  end
end
