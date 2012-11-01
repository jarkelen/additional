# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  password_digest				:string(255)
#  first_name             :string(255)
#  middle_name            :string(255)
#  last_name              :string(255)
#  position               :string(255)
#  department             :string(255)
#  role										:string(255)
#  locale									:string(255)
#  sign_in_count          :integer         default(0)
#  last_sign_in_at        :datetime
#	 mod_platform           :boolean
#  mod_insurance          :boolean
#  company_id             :integer
#  created_at             :datetime
#  updated_at             :datetime
#
class User < ActiveRecord::Base 
  before_validation :create_random_password, :on => :create
  before_validation :set_mods
  
  belongs_to :company
  has_many :activities
  has_many :notes
  has_many :tasks
  has_many :bids
  has_many :agreements
  has_many :dossiers
  
  has_secure_password
  
  attr_accessible :first_name, :middle_name, :last_name, :email, :password, :position, :department,
                  :locale, :role, :sign_in_count, :last_sign_in_at, :mod_platform, :mod_insurance,
                  :company
                  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  FIRST_NAME_MAX_LENGTH = 25
  LAST_NAME_MAX_LENGTH  = 50
  EMAIL_MAX_LENGTH      = 50

  validates :first_name, 	:presence 	=> true,
  												:length   	=> { :maximum => FIRST_NAME_MAX_LENGTH }
  validates :last_name, 	:presence 	=> true,
  												:length   	=> { :maximum => LAST_NAME_MAX_LENGTH }
  validates :email, 			:presence 	=> true,
  												:length   	=> { :maximum => EMAIL_MAX_LENGTH },
  												:format   	=> { :with => email_regex },
  												:uniqueness => { :case_sensitive => false }

  validates :role, :company, :presence 	=> true

  def self.dropdown_list(user)
    where("company_id = ?", user.company).map { |user| [user.full_name, user.id] }
  end

  def update_sign_in_stats
    update_attributes(last_sign_in_at: Time.now, sign_in_count: sign_in_count + 1)
  end

  # Get module subscription and translate it
  def get_module_subscription(mod)
    (mod) ? I18n.t(:bool_yes) : I18n.t(:bool_no)
  end
  
  # Create a full name form the name parts
  def full_name
    full_name = first_name 
    full_name += ' ' + middle_name if middle_name
    full_name += ' ' + last_name 
  end

  # Check if current user is allowed to do something based on his role
  def allowed?(required_level)
  	# Required level is level and all levels above (1=low, 4=high)
  	# level 1: customer
  	# level 2: user
  	# level 3: company_admin
  	# level 4: admin
    case required_level
  		when 'user'
		    return true if self.role == 'user' || self.role == 'company_admin' || self.role == 'admin'
  		when 'company_admin'
		    return true if self.role == 'company_admin' || self.role == 'admin'
  		when 'admin'
		    return true if self.role == 'admin'
      else
        return false
		end
  end

  # Get all active projects for current user
  def get_active_projects
    tms_projects.where('start_date <= ?', Time.now).where('end_date IS NULL OR end_date >= ?', Time.now)
  end

  private 
  def set_mods
    self.mod_mobility  = true
    self.mod_timesheet = true
  end
  
  private 
  def create_random_password
    self.password = SecureRandom.hex(5)
  end

end
