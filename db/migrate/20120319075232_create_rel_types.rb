class CreateRelTypes < ActiveRecord::Migration
  def change
    create_table :rel_types do |t|
      t.string :rel_type
      t.integer :company_id

      t.timestamps
    end
  end
end
