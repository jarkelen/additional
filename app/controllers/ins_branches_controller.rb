class InsBranchesController < ApplicationController
	# Set authorization
	before_filter do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :create ] do |c| c.correct_company 'ins_branch' end

	#-----------------------------------------------------------------------------------------

	def create
		@branch = InsBranch.new(params[:ins_branch])
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
end