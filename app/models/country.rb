# == Schema Information
#
# Table name: countries
#
#  id         :integer         not null, primary key
#  country    :string(255)
#  company_id :integer
#  created_at :datetime
#  updated_at :datetime
#
class Country < ActiveRecord::Base
	belongs_to :company

  default_scope :order => 'country ASC'

	attr_accessible :country, :company_id
                  
  validates       :country, :company_id, presence: true
    
  def self.dropdown_list
    all.map { |c| [c.country] }
  end
end

