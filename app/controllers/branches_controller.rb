class BranchesController < ApplicationController
	# Set authorization
  before_filter do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :create ] do |c| c.correct_company 'branch' end

	#-------------------------------------------------------------------------------------------------------------------

  # POST /branches
  def create
    @branch = Branch.new(branch_params)

    respond_to do |format|
      if @branch.save
        @branches = Branch.where(company_id: current_user.company.id)
        @branch = Branch.new
        format.html
	      format.js
	    end
    end
  end

  # DELETE /branches/1
  def destroy
    @branch = Branch.find(params[:id])
    @branch.destroy

    respond_to do |format|
      @branches = Branch.where(company_id: current_user.company.id)
      format.html
      format.js
    end
  end

  private

  def branch_params
    params.require(:branch).permit(:branch, :sector_id, :company_id)
  end

end
