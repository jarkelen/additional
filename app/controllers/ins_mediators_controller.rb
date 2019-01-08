class InsMediatorsController < ApplicationController
	# Set authorization
	before_action do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_action except: [ :create ] do |c| c.correct_company 'ins_mediator' end

	#-----------------------------------------------------------------------------------------

	def create
		@mediator = InsMediator.new(ins_mediators_params)
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

  private

  def ins_mediators_params
    params.require(:ins_mediator).permit(:company_id, :mediator)
  end

end
