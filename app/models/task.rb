class Task < ActiveRecord::Base
	belongs_to :contact
	belongs_to :user

  validates       :task, :user_id, :due_at, :contact_id, presence: true
end
