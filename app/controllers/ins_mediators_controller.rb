class InsMediatorsController < ApplicationController
	# Set authorization
	before_filter do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :create ] do |c| c.correct_company 'ins_mediator' end

	#-----------------------------------------------------------------------------------------

	def create
		@mediator = InsMediator.new(params[:ins_mediator])
		respond_to do |format|
			if @mediator.save
				@mediators = InsMediator.where("company_id = ?", current_user.company_id)
				@mediator = InsMediator.new

				format.js
			end
		end
	end

	def destroy
		@mediator = InsMediator.find(params[:id])
		@mediator.destroy

		respond_to do |format|
			@mediators = InsMediator.where("company_id = ?", current_user.company_id)

			format.js
		end
	end
end
