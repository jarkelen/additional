class Relation < ActiveRecord::Base
  belongs_to :company
  has_many :contacts, dependent:  :destroy
  has_many :tasks, through:  :contacts
  has_many :notes, through:  :contacts
  has_many :agreements, through:  :contacts
  has_many :ins_insurances, dependent:  :destroy
  #has_many :claims, dependent: :destroy

  # Geocode the address to create the Google map
  #acts_as_gmappable :lat:  "latitude", :lng:  "longitude"

  attr_accessor :same, :relationgroup_new

  before_validation :set_new_relationgroup

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :relation_nr, :relation_type, :status, :company_contact,
            :visit_address, :visit_zipcode, :visit_city, :visit_country, :company_id,
            presence: true
  validates :relation_nr, uniqueness: true, on:  :create
  validates :kvk_nr, uniqueness: true, on:  :create

  #------------------------------- CLASS METHODS -------------------------------

  # Get searched relations
  def self.search(search_params)
    order("relation_nr ASC").where(['name LIKE ? OR visit_city LIKE ? OR status LIKE ? OR relation_type LIKE ? OR industry LIKE ? OR branch LIKE ? OR relation_nr LIKE ? OR relationgroup LIKE ?', ["%#{search_params}%"]*8].flatten)
  end

  # Get filtered relations
  def self.filter(params)
    conditions = {}

    # Filter on relation
    unless params[:name].blank?
      conditions[:name] = params[:name]
    end

    # Filter on relation_nr
    unless params[:relation_nr].blank?
      conditions[:relation_nr] = params[:relation_nr]
    end

    # Filter on status
    unless params[:status].blank?
      conditions[:status] = params[:status]
    end

    # Filter on visit city
    unless params[:city].blank?
      conditions[:visit_city] = params[:city]
    end

    # Filter on relation type
    unless params[:type].blank?
      conditions[:relation_type] = params[:type]
    end

    # Find filtered relations
    order("relation_nr ASC").where(conditions)
  end

  # Get current user's company code
  def self.get_company_code(user)
    user.company.code
  end

  # Calculate new relation sequence
  def self.get_new_relation_nr(user)
    latest_nr = user.company.relations.maximum("relation_nr")
    if latest_nr.blank?
      new_nr = 1
    else
      new_nr = latest_nr[3,(latest_nr.length - 3)]
      new_nr = new_nr.to_i + 1
    end

    # Add leading zeros
    new_nr = Relation.add_leading_zeros(new_nr)
    return new_nr
  end

  # Add leading zeros to a number
  def self.add_leading_zeros(nr)
    # Determine leading zeros
    nr_zeros = 4 - nr.to_s.length
    counter = 0
    zeros = ""
    while counter < nr_zeros
      zeros = zeros + "0"
      counter = counter + 1
    end
    nr = zeros + nr.to_s
    return nr
  end

  # Fill a dropdown list with grouped relationgroups
  def self.dropdown_list
    #all(group: 'id',relationgroup').map { |relation| [relation.relationgroup, relation.relationgroup] }
  end

  #------------------------------- INSTANCE METHODS -------------------------------

  # Sets a new relationgroup as relationgroup for this relation
  private
  def set_new_relationgroup
    unless self.relationgroup_new.blank?
      self.relationgroup = self.relationgroup_new
    end
  end

  #------------------------------- OTHER -------------------------------

  def gmaps4rails_address
    "#{self.visit_address}, #{self.visit_zipcode}, #{self.visit_city}"
  end

  def gmaps4rails_infowindow
    "#{self.name}<br><br>
     #{self.visit_address}<br>
     #{self.visit_zipcode}<br>
     #{self.visit_city}<br>
     #{self.visit_country}<br><br>
     <a href='/relations/#{self.id}'>more details"
  end


end
