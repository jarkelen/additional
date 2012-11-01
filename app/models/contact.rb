# == Schema Information
#
# Table name: contacts
#
#  id                 :integer         not null, primary key
#  first_name         :string(255)
#  middle_name        :string(255)
#  last_name          :string(255)
#  email              :string(255)
#  function           :string(255)
#  telephone_business :string(255)
#  telephone_private  :string(255)
#  telephone_mobile   :string(255)
#  twitter            :string(255)
#  facebook           :string(255)
#  linkedin           :string(255)
#  background         :text
#  salutation         :string(255)
#  gender             :string(255)
#  title              :string(255)
#  fax                :string(255)
#  birth_date         :date
#  custom_label_1     :string(255)
#  custom_field_1     :string(255)
#  custom_label_2     :string(255)
#  custom_field_2     :string(255)
#  custom_label_3     :string(255)
#  custom_field_3     :string(255)
#  has_boss           :integer
#  relation_id        :integer
#  created_at         :datetime
#  updated_at         :datetime
#
class Contact < ActiveRecord::Base
  belongs_to :relation
  has_and_belongs_to_many :dossiers
  has_many :notes, :order => 'created_at DESC',:dependent => :destroy
  has_many :tasks, :order => 'due_at ASC',:dependent => :destroy
  has_many :agreements, :order => 'updated_at ASC',:dependent => :destroy
         
  attr_accessible :first_name, :middle_name, :last_name, :function, 
                  :telephone_business, :telephone_private, :telephone_mobile,
                  :email, :facebook, :twitter, :linkedin, :salutation, :gender, 
                  :background, :title, :birth_date, :fax, :relation_id, 
                  :custom_label_1, :custom_field_1, :custom_label_2, :custom_field_2, 
                  :custom_label_3, :custom_field_3, :has_boss

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
                  
  validates :first_name, :last_name, :relation_id, presence: true

  #------------------------------- CLASS METHODS -------------------------------

  # Find all contacts for a specific search query
  def self.search(search_params)
    order("last_name ASC").where('first_name LIKE ? OR last_name LIKE ? OR function LIKE ?', "%#{search_params}%", "%#{search_params}%", "%#{search_params}%")
  end

  # Find all contacts for a specific letter
  def self.per_letter(letter_params)
    order("last_name ASC").where("last_name LIKE ?", letter_params + "%")
  end

  # Set an array with all alphabet letters
  def self.set_alphabet_letters
    ("A".."Z").to_a
  end

  # Determine last name letters of this relation's contacts
  def self.get_lastname_letters(contacts)
    contact_array = []
    contacts.each do |contact|
      contact_array << contact.last_name[0,1]
    end

    # Sort array alphabetically in ASC order
    contact_array.sort!

    # Remove duplicate elements
    contact_array.uniq!

    return contact_array
  end

  # Get all contacts or contacts for a specific last name
  def self.get_contacts(params)
    if params[:letter]
      order("last_name ASC").where("last_name LIKE ?", params[:letter] + "%")
    else
      order("last_name ASC")
    end
  end

  #------------------------------- INSTANCE METHODS -------------------------------

  # Create a full name form the name parts
  def full_name
    full_name = self.first_name if self.first_name
    full_name = full_name + ' ' + self.middle_name if self.middle_name
    full_name = full_name + ' ' + self.last_name if self.last_name
  end

end
