# == Schema Information
#
# Table name: rel_types
#
#  id                   :integer         not null, primary key
#  rel_type   	        :string(255)
#  company_id      	    :integer
#  created_at           :datetime
#  updated_at           :datetime
#
class RelType < ActiveRecord::Base
	belongs_to :company

  validates       :rel_type, :company_id, presence: true

  def self.dropdown_list
    all.map { |rt| [rt.rel_type] }
  end
  
end
