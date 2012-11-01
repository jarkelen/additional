class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :type
      t.string :title
      t.string :subject
      t.text :note
      t.integer :user_id
      t.integer :contact_id

      t.timestamps
    end
  end
end
