class AddInsurerToInsInsurance < ActiveRecord::Migration
  def change
    add_column :ins_insurances, :insurer, :string
  end
end
