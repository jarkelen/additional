class Sector < ActiveRecord::Base
	belongs_to :company
  has_many :branches
  
  default_scope :order => 'sector ASC'

  validates       :sector, :company_id, presence: true
end

