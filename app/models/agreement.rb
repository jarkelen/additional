# == Schema Information
#
# Table name: agreements
#
#  id         :integer         not null, primary key
#  agreement  :string(255)
#  user_id    :integer
#  contact_id :integer
#  dossier_id :integer
#  created_at :datetime
#  updated_at :datetime
#
class Agreement < ActiveRecord::Base
	belongs_to :contact
	belongs_to :user
  belongs_to :dossier

	attr_accessible :agreement, :user_id, :contact_id, :dossier_id
                  
  validates :agreement, 	:presence 	=> true,
													:length   	=> { :maximum => 75 }
  validates :user_id, 		:presence 	=> true
  validates :contact_id, 	:presence 	=> true

end