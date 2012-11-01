# == Schema Information
#
# Table name: dossier_statuses
#
#  id         		:integer         not null, primary key
#  status		  		:string(255)
#  company_id 		:integer
#  created_at 		:datetime
#  updated_at 		:datetime
#
class DossierStatus < ActiveRecord::Base
	belongs_to :company

	attr_accessible :status, :company_id
                  
  validates       :status, :company_id, presence: true

  def self.dropdown_list
    all.map { |ds| [ds.status] }
  end
  
end
