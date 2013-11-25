class AddMediatorToInsInsurance < ActiveRecord::Migration
  def change
    add_column :ins_insurances, :mediator, :string
  end
end
