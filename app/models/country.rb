
class Country < ActiveRecord::Base
	belongs_to :company

  default_scope { order('country ASC') }

  validates :country, :company_id, presence: true

  def self.dropdown_list
    all.map { |c| [c.country] }
  end
end
