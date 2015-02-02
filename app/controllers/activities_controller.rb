class ActivitiesController < ApplicationController

  # GET /activities
  def index
		@activities_all = Activity.paginate(page:  params[:page], per_page:  30).find(:all, conditions:  [ "company_id = ?", current_user.company.id], order:  "created_at DESC")
	end

  # DELETE /activity/1
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.js
    end
  end

end
