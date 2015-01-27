class Note < ActiveRecord::Base
	belongs_to :contact
	belongs_to :user

	# Add note uploader
	mount_uploader :attachment, AttachmentUploader

  validates       :note_type, :subject, :note, :user_id, :contact_id, presence: true
end

