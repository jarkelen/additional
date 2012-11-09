class Note < ActiveRecord::Base
	belongs_to :contact
	belongs_to :user

	# Add note uploader
	mount_uploader :attachment, AttachmentUploader

	attr_accessible :note_type, :subject, :note, :user_id, :contact_id, :attachment, 
                  :url
                  
  validates       :note_type, :subject, :note, :user_id, :contact_id, presence: true
end

