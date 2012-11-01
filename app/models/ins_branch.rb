# == Schema Information
#
# Table name: ins_branches
#
#  id          :integer         not null, primary key
#  branch      :string(255)
#  company_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#
class InsBranch < ActiveRecord::Base
	belongs_to :company
	has_many :ins_types

	default_scope :order => 'branch ASC'

	attr_accessible :branch, :company_id

	validates       :branch, :company_id, presence: true
end
