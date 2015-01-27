class InsInsurer < ActiveRecord::Base
  validates :insurer, :company_id, presence: true
end
