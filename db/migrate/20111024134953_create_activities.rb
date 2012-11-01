class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :activity
      t.integer :user_id

      t.timestamps
    end
  end
end
