# == Schema Information
#
# Table name: tasktypes
#
#  id         		:integer         not null, primary key
#  tasktype 		  :string(255)
#  company_id 		:integer
#  created_at 		:datetime
#  updated_at 		:datetime
#
class Tasktype < ActiveRecord::Base
	belongs_to :company

	attr_accessible :tasktype, :company_id
                  
  validates       :tasktype, :company_id, presence: true

  def self.dropdown_list
    all.map { |tt| [tt.tasktype] }
  end
  
end
