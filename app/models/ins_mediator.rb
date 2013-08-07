class InsMediator < ActiveRecord::Base
  attr_accessible :company_id, :mediator

  validates :mediator, :company_id, presence: true
end
