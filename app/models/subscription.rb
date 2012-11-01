# == Schema Information
#
# Table name: subscriptions
#
#  id         		:integer         not null, primary key
#  name       		:string(255)
#	 discount				:integer
#  start_date			:datetime
#	 billing_period	:string(255)
#  user_price			:float
#  active					:boolean
#  company_id			:integer
#  created_at 		:datetime
#  updated_at 		:datetime
#
class Subscription < ActiveRecord::Base
	belongs_to :company
	
  attr_accessible :name, :discount, :start_date, :billing_period, :user_price, :active, :company_id

  validates       :name, :start_date, :billing_period, :user_price, :active, presence: true
	
end
