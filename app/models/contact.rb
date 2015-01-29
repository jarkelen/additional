class Contact < ActiveRecord::Base
  belongs_to :relation
  has_many :notes,:dependent => :destroy
  has_many :tasks,:dependent => :destroy
  has_many :agreements,:dependent => :destroy

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
