class Company < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :relations, dependent: :destroy
  has_many :contacts, through: :relations
  has_many :claims, through: :relations
  has_many :notes, through: :contacts
  has_many :tasks, through: :contacts
  has_many :agreements, through: :contacts
  has_one :subscription, dependent: :destroy

	# Support
  has_many :countries, dependent: :destroy
  has_many :sectors, dependent: :destroy
  has_many :branches, dependent: :destroy
  has_many :tasktypes, dependent: :destroy
  has_many :rel_types, dependent: :destroy

  # Modules
  has_many :ins_insurances, dependent: :destroy
  has_many :ins_branches, dependent: :destroy
  has_many :ins_types, dependent: :destroy
  has_many :ins_markets, dependent: :destroy
  has_many :ins_insurers, dependent: :destroy
  has_many :ins_mediators, dependent: :destroy

	# Add logo uploader
	mount_uploader :logo, LogoUploader

  accepts_nested_attributes_for :subscription

  attr_accessor :same

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates       		:name, address1, zipcode, city, country, code, presence: true
  validates_length_of :code, maximum: 3
  validates 					:email, presence: true,
  										format: { with: email_regex },
  										uniqueness: { case_sensitive: false }

end
