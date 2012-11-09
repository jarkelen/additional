
class Country < ActiveRecord::Base
	belongs_to :company

  default_scope :order => 'country ASC'

	attr_accessible :country, :company_id
                  
  validates       :country, :company_id, presence: true
    
  def self.dropdown_list
    all.map { |c| [c.country] }
  end
end

