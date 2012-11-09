class Subscription < ActiveRecord::Base
	belongs_to :company
	
  attr_accessible :name, :discount, :start_date, :billing_period, :user_price, :active, :company_id

  validates       :name, :start_date, :billing_period, :user_price, :active, presence: true
	
end
