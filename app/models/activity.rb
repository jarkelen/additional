class Activity < ActiveRecord::Base
	belongs_to :user

	validates :activity, :user_id, :company_id, presence: true

  # Create a new sidebar update
  def self.create_update(user, activity)
    self.create(:activity => activity, :user_id => user.id, :company_id => user.company.id)
	end
    
end
