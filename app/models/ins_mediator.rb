class InsMediator < ActiveRecord::Base
  validates :mediator, :company_id, presence: true
end
