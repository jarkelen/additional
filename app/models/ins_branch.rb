class InsBranch < ActiveRecord::Base
	belongs_to :company
	has_many :ins_types

	default_scope :order => 'branch ASC'

	attr_accessible :branch, :company_id

	validates       :branch, :company_id, presence: true
end
