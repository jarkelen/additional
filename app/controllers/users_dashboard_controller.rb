class UsersDashboardController < ApplicationController
  def show
  	# Find first expiring insurances
    @insurances = current_user.company.ins_insurances.where("first_contract_expiration_date >= ?", Date.today).order("first_contract_expiration_date ASC").limit(25)
  end

end
