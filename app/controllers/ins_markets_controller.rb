class InsMarketsController < ApplicationController
	# Set authorization
	before_action do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_action except: [ :create ] do |c| c.correct_company 'ins_market' end

	#-----------------------------------------------------------------------------------------

	def create
		@market = InsMarket.new(ins_markets_params)
		respond_to do |format|
			if @market.save
				@markets = InsMarket.where("company_id = ?", current_user.company_id)
				@market = InsMarket.new

				format.js
			end
		end
	end

	def destroy
		@market = InsMarket.find(params[:id])
		@market.destroy

		respond_to do |format|
			@markets = InsMarket.where("company_id = ?", current_user.company_id)

			format.js
		end
	end

  private

  def ins_markets_params
    params.require(:ins_market).permit(:market, :company_id)
  end

end
