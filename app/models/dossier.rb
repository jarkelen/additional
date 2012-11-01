# == Schema Information
#
# Table name: dossiers
#
#  id         :integer         not null, primary key
#  title	  	:string(255)
#  status	  	:string(255)
#  budget	  	:string(255)
#  fte		  	:float
#  user_id    :integer
#  company_id :integer
#  created_at :datetime
#  updated_at :datetime
#
class Dossier < ActiveRecord::Base
	belongs_to :company
	has_many :tasks
	has_many :notes
	has_many :agreements
	has_and_belongs_to_many :contacts

	attr_accessible :title, :status, :budget, :fte, :user_id, :company_id
                  
  validates       :title, :status, :user_id, presence: true

  #------------------------------- CLASS METHODS -------------------------------
  
  # Show all dossiers for current company
  def self.dropdown_list(user)
    user.company.dossiers.all.map { |dossier| [dossier.title, dossier.id] }
  end

end
