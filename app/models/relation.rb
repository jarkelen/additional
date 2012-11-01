# == Schema Information
#
# Table name: relations
#
#  id                :integer         not null, primary key
#  relation_nr       :string(255)
#  name              :string(255)
#  company_contact   :integer
#  website           :string(255)
#  kvk_nr            :integer
#  industry          :integer
#  legal             :string(255)
#  nr_employees      :string(255)
#  telephone   			 :string(255)
#  fax         			 :string(255)
#  email       			 :string(255)
#  facebook          :string(255)
#  twitter           :string(255)
#  linkedin          :string(255)
#  billing_address   :string(255)
#  billing_zipcode   :string(255)
#  billing_city      :string(255)
#  billing_country   :string(255)
#  visit_address     :string(255)
#  visit_zipcode     :string(255)
#  visit_city        :string(255)
#  visit_country     :string(255)
#  post_address      :string(255)
#  post_zipcode      :string(255)
#  post_city         :string(255)
#  post_country      :string(255)
#  remarks           :text
#  relation_type     :string(255)
#  status				     :string(255)
#  latitude				   :float
#  longitude				 :float
#  gmaps			     	 :boolean
#  logo			     	 	 :string(255)
#  branch		     	 	 :integer
#  bankaccount			 :string(255)
#  custom_label_1    :string(255)
#  custom_field_1    :string(255)
#  custom_label_2    :string(255)
#  custom_field_2    :string(255)
#  custom_label_3    :string(255)
#  custom_field_3    :string(255)
#	 company_id				 :integer
#  created_at        :datetime
#  updated_at        :datetime
#
class Relation < ActiveRecord::Base
  belongs_to :company
  has_many :contacts, :dependent => :destroy
  has_many :tasks, :through => :contacts
  has_many :notes, :through => :contacts
  has_many :agreements, :through => :contacts
  has_many :ins_insurances
  has_many :tms_projects, :dependent => :destroy
  
  
	# Geocode the address to create the Google map
  acts_as_gmappable :lat => "latitude", :lng => "longitude"
	
	# Add logo uploader
	mount_uploader :logo, LogoUploader

  attr_accessor :same, :relationgroup_new
    
  attr_accessible :name, :relation_nr, :relation_type, :status, :company_contact, 
                  :website, :kvk_nr, :industry, :branch, :legal, :nr_employees, 
                  :telephone, :fax, :email, :facebook, :twitter, :linkedin, 
                  :billing_address, :billing_zipcode, :billing_city, :billing_country, 
                  :visit_address, :visit_zipcode, :visit_city, :visit_country, :remarks,
                  :latitude, :longitude, :gmaps, :logo, :bankaccount, :post_address, 
                  :post_zipcode, :post_city, :post_country, :custom_label_1, 
                  :custom_field_1, :custom_label_2, :custom_field_2, :custom_label_3,
                  :custom_field_3, :relationgroup, :company_id,:same, :relationgroup_new

  before_validation :set_new_relationgroup

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :relation_nr, :relation_type, :status, :company_contact, 
            :visit_address, :visit_zipcode, :visit_city, :visit_country, :company_id,
            presence: true
  validates :relation_nr, :uniqueness => true, :on => :create
  validates :kvk_nr, :uniqueness => true, :on => :create

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
    all(:group => 'relationgroup').map { |relation| [relation.relationgroup, relation.relationgroup] }
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
