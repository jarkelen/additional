class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :update
      t.integer :user_id

      t.timestamps
    end
  end
end
