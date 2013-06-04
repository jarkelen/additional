class AddStatusToInsInsurances < ActiveRecord::Migration
  def change
    add_column :ins_insurances, :status, :string, default: "actief"
    add_column :ins_insurances, :end_date, :datetime
  end
end
