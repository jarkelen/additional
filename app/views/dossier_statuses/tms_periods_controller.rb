class TmsPeriodsController < ApplicationController
	# Set authorization
	before_filter do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :create ] do |c| c.correct_company 'tms_period' end

	#-------------------------------------------------------------------------------------------------------------------

	def create
		@period = TmsPeriod.new(params[:tms_period])

		respond_to do |format|
			if @period.save
				@periods = TmsPeriod.find_all_by_company_id(current_user.company.id)
				@period = TmsPeriod.new
				format.html
				format.js
			end
		end
	end

	def destroy
		@period = TmsPeriod.find(params[:id])
		@period.destroy

		respond_to do |format|
			@periods = TmsPeriod.find_all_by_company_id(current_user.company.id)
			format.html
			format.js
		end
	end

end
