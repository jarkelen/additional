class RelTypesController < ApplicationController
	# Set authorization
  before_filter do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :create ] do |c| c.correct_company 'rel_type' end

	#-------------------------------------------------------------------------------------------------------------------

  def create
    @rel_type = RelType.new(params[:rel_type])

    respond_to do |format|
      if @rel_type.save
        @rel_types = RelType.find_all_by_company_id(current_user.company.id)
        @rel_type = RelType.new
        format.html
	      format.js
	    end
    end
  end

  def destroy
    @rel_type = RelType.find(params[:id])
    @rel_type.destroy

    respond_to do |format|
      @rel_types = RelType.find_all_by_company_id(current_user.company.id)
      format.html
      format.js
    end
  end

end
