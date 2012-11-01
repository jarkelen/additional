class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :branch
      t.integer :relation_id

      t.timestamps
    end
  end
end
