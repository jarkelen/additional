class UsersDashboardController < ApplicationController
  def show
  	# Find first expiring insurances
    @insurances = current_user.company.ins_insurances.order("main_premium_expiration_date ASC").limit(15)
  end

end
