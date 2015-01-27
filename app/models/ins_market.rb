class InsMarket < ActiveRecord::Base
	belongs_to :company

	default_scope :order => 'market ASC'

	validates       :market, :company_id, presence: true
end
