class Task < ActiveRecord::Base
	belongs_to :contact
	belongs_to :user

	attr_accessible :task_type, :task, :due_at, :user_id, :contact_id
                  
  validates       :task_type, :task, :user_id, :due_at, :contact_id, presence: true
end
