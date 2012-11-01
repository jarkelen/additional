# == Schema Information
#
# Table name: notes
#
#  id         :integer         not null, primary key
#  note_type  :string(255)
#  subject    :string(255)
#  note       :text
#  user_id    :integer
#  contact_id :integer
#  dossier_id :integer
#  attachment :string(255)
#  url			  :string(255)
#  created_at :datetime
#  updated_at :datetime
#
#require 'file_size_validator'

class Note < ActiveRecord::Base
	belongs_to :contact
	belongs_to :user
  belongs_to :dossier

	# Add note uploader
	mount_uploader :attachment, AttachmentUploader

	attr_accessible :note_type, :subject, :note, :user_id, :contact_id, :attachment, 
                  :url, :dossier_id
                  
  validates       :note_type, :subject, :note, :user_id, :contact_id, presence: true
end

