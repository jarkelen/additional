class InsTypesController < ApplicationController
	# Set authorization
	before_filter do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :create ] do |c| c.correct_company 'ins_type' end

	#-----------------------------------------------------------------------------------------

	def create
		@type = InsType.new(ins_types_params)
	
		respond_to do |format|
			if @type.save
				@branches = InsBranch.where("company_id = ?", current_user.company_id)
				@types = InsType.where("company_id = ?", current_user.company_id)
				@type = InsType.new

				format.js
			end
		end
	end

	def destroy
		@type = InsType.find(params[:id])
		@type.destroy

		respond_to do |format|
			@branches = InsBranch.where("company_id = ?", current_user.company_id)
			@types = InsType.where("company_id = ?", current_user.company_id)
			
			format.js
		end
	end
	
  private
  
  def ins_types_params
    params.require(:ins_type).permit(:ins_type, :ins_branch_id, :company_id)
  end

end
