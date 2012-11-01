class DossierStatusesController < ApplicationController
	# Set authorization
  before_filter do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :create ] do |c| c.correct_company 'dossier_status' end

	#-------------------------------------------------------------------------------------------------------------------

  # POST /dossier_statuses
  def create
    @dossier_status = DossierStatus.new(params[:dossier_status])

    respond_to do |format|
      if @dossier_status.save
        @dossier_statuses = DossierStatus.find_all_by_company_id(current_user.company.id)
        @dossier_status = DossierStatus.new
        format.html
	      format.js
	    end
    end
  end

  # DELETE /dossier_statuses/1
  def destroy
    @dossier_status = DossierStatus.find(params[:id])
    @dossier_status.destroy

    respond_to do |format|
      @dossier_statuses = DossierStatus.find_all_by_company_id(current_user.company.id)
      format.html
      format.js
    end
  end

end
