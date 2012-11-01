class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
      t.string :sector
      t.integer :company_id

      t.timestamps
    end
  end
end
