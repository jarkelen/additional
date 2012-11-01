class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :task_type
      t.string :task
      t.datetime :due_at
      t.integer :contact_id
      t.integer :user_id

      t.timestamps
    end
  end
end
