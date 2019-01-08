class Note < ActiveRecord::Base
	belongs_to :contact
	belongs_to :user

  validates       :note_type, :subject, :note, :user_id, :contact_id, presence: true
end

