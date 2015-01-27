class Subscription < ActiveRecord::Base
	belongs_to :company
	
  validates       :name, :start_date, :billing_period, :user_price, :active, presence: true
	
end
