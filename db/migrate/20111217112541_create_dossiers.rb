class CreateDossiers < ActiveRecord::Migration
  create_table :dossiers do |t|
    t.string :title
    t.string :status
    t.string :budget
    t.integer :user_id

    t.timestamps
  end
end
