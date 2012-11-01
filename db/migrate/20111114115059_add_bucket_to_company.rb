class AddBucketToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :bucket, :string
  end
end
