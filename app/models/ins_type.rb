# == Schema Information
#
# Table name: ins_types
#
#  id          :integer         not null, primary key
#  ins_type    :string(255)
#  ins_branch_id   :integer
#  company_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#
class InsType < ActiveRecord::Base
	belongs_to :company
	belongs_to :ins_branch

	default_scope :order => 'ins_type ASC'

	attr_accessible :ins_type, :ins_branch_id, :company_id

	validates       :ins_type, :ins_branch_id, :company_id, presence: true
end

