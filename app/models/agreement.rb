class Agreement < ActiveRecord::Base
	belongs_to :contact
	belongs_to :user

  validates :agreement, :user_id, :contact_id, :presence => true
end