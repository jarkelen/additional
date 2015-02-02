class Claim < ActiveRecord::Base
	belongs_to :relation
	belongs_to :company

	validates :claim_nr, :relation_id, :company_id, presence: true

end
