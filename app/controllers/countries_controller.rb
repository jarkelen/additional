class CountriesController < ApplicationController
	# Set authorization
  before_filter do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :create ] do |c| c.correct_company 'country' end

	#-------------------------------------------------------------------------------------------------------------------

  # POST /countries
  def create
    @country = Country.new(country_params)

    respond_to do |format|
      if @country.save
        @countries = Country.where(company_id: current_user.company.id)
        @country = Country.new
        format.html
	      format.js
	    end
    end
  end

  # DELETE /countries/1
  def destroy
    @country = Country.find(params[:id])
    @country.destroy

    respond_to do |format|
      @countries = Country.where(company_id: current_user.company.id)
      format.html
      format.js
    end
  end

  private

  def country_params
    params.require(:country).permit(:country, :company_id)
  end

end
