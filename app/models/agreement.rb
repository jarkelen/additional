class Agreement < ActiveRecord::Base
	belongs_to :contact
	belongs_to :user

	attr_accessible :agreement, :user_id, :contact_id
                  
  validates :agreement, :user_id, :contact_id, :presence => true
end