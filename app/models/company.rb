# == Schema Information
#
# Table name: companies
#
#  id         			:integer         not null, primary key
#  name       			:string(255)
#  address1   			:string(255)
#  address2   			:string(255)
#  zipcode    			:string(255)
#  city      			  :string(255)
#  country    			:string(255)
#  email      			:string(255)
#  website    			:string(255)
#  telephone  			:string(255)
#  twitter    			:string(255)
#  facebook   			:string(255)
#  linkedin   			:string(255)
#  code       			:string(255)
#  kvk_nr           :integer
#  bankaccount			:string(255)
#  tax_nr			      :string(255)
#  billing_address  :string(255)
#  billing_zipcode  :string(255)
#  billing_city     :string(255)
#  billing_country  :string(255)
#  post_address     :string(255)
#  post_zipcode     :string(255)
#  post_city        :string(255)
#  post_country     :string(255)
#  logo             :string(255)
#  created_at 			:datetime
#  updated_at 			:datetime
#
class Company < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :relations, :dependent => :destroy
  has_many :contacts, :through => :relations
  has_many :notes, :through => :contacts
  has_many :tasks, :through => :contacts
  has_many :agreements, :through => :contacts
  has_many :dossiers, :dependent => :destroy
  has_many :alerts, :dependent => :destroy
  has_one :subscription, :dependent => :destroy

	# Support
  has_many :countries, :dependent => :destroy
  has_many :dossier_statuses, :dependent => :destroy
  has_many :sectors, :dependent => :destroy
  has_many :branches, :dependent => :destroy
  has_many :tasktypes, :dependent => :destroy
  has_many :rel_types, :dependent => :destroy

  # Modules
  has_many :ins_insurances, :dependent => :destroy
  has_many :ins_branches, :dependent => :destroy
  has_many :ins_types, :dependent => :destroy
  has_many :ins_markets, :dependent => :destroy
  
	# Add logo uploader
	mount_uploader :logo, LogoUploader

  accepts_nested_attributes_for :subscription
  
  attr_accessible :name, :address1, :address2, :zipcode, :city, :country, :email, :website,
                  :telephone, :facebook, :twitter, :linkedin, :code, 
                  :subscription_attributes, :kvk_nr, :bankaccount, :billing_address, 
                  :billing_zipcode, :billing_city, :billing_country,
                  :post_address, :post_zipcode, :post_city, :post_country, :tax_nr, :logo

  attr_accessor :same
                  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates       		:name, :address1, :zipcode, :city, :country, :code, presence: true
  validates_length_of :code, :maximum => 3
  validates 					:email, 	:presence 	=> true,
  										:format   	=> { :with => email_regex },
  										:uniqueness => { :case_sensitive => false }
  
end

