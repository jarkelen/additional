# == Schema Information
#
# Table name: ins_markets
#
#  id          :integer         not null, primary key
#  market      :string(255)
#  company_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#
class InsMarket < ActiveRecord::Base
	belongs_to :company

	default_scope :order => 'market ASC'

	attr_accessible :market, :company_id

	validates       :market, :company_id, presence: true
end
