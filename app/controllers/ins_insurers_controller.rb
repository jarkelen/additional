class InsInsurersController < ApplicationController
	# Set authorization
	before_action do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_action except: [ :create ] do |c| c.correct_company 'ins_insurer' end

	#-----------------------------------------------------------------------------------------

	def create
		@insurer = InsInsurer.new(ins_insurers_params)
		respond_to do |format|
			if @insurer.save
				@insurers = InsInsurer.where("company_id = ?", current_user.company_id)
				@insurer = InsInsurer.new

				format.js
			end
		end
	end

	def destroy
		@insurer = InsInsurer.find(params[:id])
		@insurer.destroy

		respond_to do |format|
			@insurers = InsInsurer.where("company_id = ?", current_user.company_id)

			format.js
		end
	end

  private

  def ins_insurers_params
    params.require(:ins_insurer).permit(:company_id, :insurer)
  end

end
