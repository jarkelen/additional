# == Schema Information
#
# Table name: branches
#
#  id          :integer         not null, primary key
#  branch      :string(255)
#  sector_id   :integer
#  comapny_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#
class Branch < ActiveRecord::Base
  belongs_to :company
	belongs_to :sector

  default_scope :order => 'sector_id, branch ASC'

	attr_accessible :branch, :sector_id, :company_id
                  
  validates       :branch, :sector_id, :company_id, presence: true
end

