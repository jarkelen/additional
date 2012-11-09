class InsMarket < ActiveRecord::Base
	belongs_to :company

	default_scope :order => 'market ASC'

	attr_accessible :market, :company_id

	validates       :market, :company_id, presence: true
end
