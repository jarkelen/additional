class CreateInsMediators < ActiveRecord::Migration
  def change
    create_table :ins_mediators do |t|
      t.string :mediator
      t.integer :company_id

      t.timestamps
    end
  end
end
