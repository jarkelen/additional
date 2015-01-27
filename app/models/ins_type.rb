class InsType < ActiveRecord::Base
	belongs_to :company
	belongs_to :ins_branch

	default_scope :order => 'ins_type ASC'

	validates       :ins_type, :ins_branch_id, :company_id, presence: true
end

