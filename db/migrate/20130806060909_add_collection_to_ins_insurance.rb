class AddCollectionToInsInsurance < ActiveRecord::Migration
  def change
    add_column :ins_insurances, :collection, :string
  end
end
