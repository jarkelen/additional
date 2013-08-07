class InsInsurer < ActiveRecord::Base
  attr_accessible :company_id, :insurer

  validates :insurer, :company_id, presence: true
end
