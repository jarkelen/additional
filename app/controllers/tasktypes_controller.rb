class TasktypesController < ApplicationController
	# Set authorization
  before_filter do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :create ] do |c| c.correct_company 'tasktype' end

	#-----------------------------------------------------------------------------------------

  def create
    @tasktype = Tasktype.new(tasktypes_params)

    respond_to do |format|
      if @tasktype.save
        @tasktypes = Tasktype.where(company_id: current_user.company.id)
        @tasktype = Tasktype.new

        format.html
	      format.js
	    end
    end
  end

  # DELETE /tasktypes/1
  def destroy
    @tasktype = Tasktype.find(params[:id])
    @tasktype.destroy

    respond_to do |format|
      @tasktypes = Tasktype.where(company_id: current_user.company.id)

      format.html
      format.js
    end
  end

  private

  def tasktypes_params
    params.require(:tasktype).permit(:tasktype, :company_id)
  end

end
