class Sector < ActiveRecord::Base
	belongs_to :company
  has_many :branches
  
  default_scope :order => 'sector ASC'

	attr_accessible :sector, :company_id
                  
  validates       :sector, :company_id, presence: true
end

