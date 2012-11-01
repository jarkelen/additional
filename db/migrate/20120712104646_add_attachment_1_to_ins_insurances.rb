class AddAttachment1ToInsInsurances < ActiveRecord::Migration
  def change
    add_column :ins_insurances, :attachment_1, :string
    add_column :ins_insurances, :attachment_2, :string
    add_column :ins_insurances, :attachment_3, :string
  end
end
