class Tasktype < ActiveRecord::Base
	belongs_to :company

	attr_accessible :tasktype, :company_id
                  
  validates       :tasktype, :company_id, presence: true

  def self.dropdown_list
    all.map { |tt| [tt.tasktype] }
  end
  
end
