class SectorsController < ApplicationController
	# Set authorization
  before_filter do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :create ] do |c| c.correct_company 'sector' end

	#-------------------------------------------------------------------------------------------------------------------

  # POST /sectors
  def create
    @sector = Sector.new(sectors_params)

    respond_to do |format|
      if @sector.save
        @sectors = Sector.where(company_id: current_user.company.id)
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
      @sectors = Sector.where(company_id: current_user.company.id)
      format.html
      format.js
    end
  end

  private

  def sectors_params
    params.require(:sector).permit(:sector, :company_id)
  end

end
