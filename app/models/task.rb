# == Schema Information
#
# Table name: tasks
#
#  id         :integer         not null, primary key
#  task_type  :string(255)
#  task    		:string(255)
#  user_id    :integer
#  contact_id :integer
#  dossier_id :integer
#  due_at 		:datetime
#  created_at :datetime
#  updated_at :datetime
#
class Task < ActiveRecord::Base
	belongs_to :contact
	belongs_to :user
  belongs_to :dossier

	attr_accessible :task_type, :task, :due_at, :user_id, :contact_id, :dossier_id
                  
  validates       :task_type, :task, :user_id, :due_at, :contact_id, presence: true
end
