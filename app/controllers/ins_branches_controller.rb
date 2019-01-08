class InsBranchesController < ApplicationController
	# Set authorization
	before_action do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_action except: [ :create ] do |c| c.correct_company 'ins_branch' end

	#-----------------------------------------------------------------------------------------

	def create
		@branch = InsBranch.new(ins_branches_params)
		respond_to do |format|
			if @branch.save
				@branches = InsBranch.where("company_id = ?", current_user.company_id)
				@branch = InsBranch.new

				format.js
			end
		end
	end

	def destroy
		@branch = InsBranch.find(params[:id])
		@branch.destroy

		respond_to do |format|
			@branches = InsBranch.where("company_id = ?", current_user.company_id)
			format.js
		end
	end

  private

  def ins_branches_params
    params.require(:ins_branch).permit(:branch, :company_id)
  end

end
