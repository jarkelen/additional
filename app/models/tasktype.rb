class Tasktype < ActiveRecord::Base
	belongs_to :company

  validates       :tasktype, :company_id, presence: true

  def self.dropdown_list
    all.map { |tt| [tt.tasktype] }
  end
  
end
