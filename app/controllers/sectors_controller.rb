class SectorsController < ApplicationController
	# Set authorization
  before_filter do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :create ] do |c| c.correct_company 'sector' end

	#-------------------------------------------------------------------------------------------------------------------

  # POST /sectors
  def create
    @sector = Sector.new(params[:sector])
    
    respond_to do |format|
      if @sector.save
        @sectors = Sector.find_all_by_company_id(current_user.company.id)
        @sector = Sector.new
        format.html
	      format.js
	    end
    end
  end

  # DELETE /sectors/1
  def destroy
    @sector = Sector.find(params[:id])
    @sector.destroy

    respond_to do |format|
      @sectors = Sector.find_all_by_company_id(current_user.company.id)
      format.html
      format.js
    end
  end

end