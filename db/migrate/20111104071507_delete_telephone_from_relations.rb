class DeleteTelephoneFromRelations < ActiveRecord::Migration
  def self.up
    change_table :relations do |t|
      t.change :billing_telephone, :string
      t.change :visit_telephone, :string
      t.change :billing_fax, :string
      t.change :visit_fax, :string
    end
  end

  def self.down
    change_table :relations do |t|
      t.change :billing_telephone, :integer
      t.change :visit_telephone, :integer
      t.change :billing_fax, :integer
      t.change :visit_fax, :integer
    end
  end
end
