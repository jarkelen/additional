class CompaniesController < ApplicationController
	# Set authorization
  before_filter :only => [ :show ] do |c| c.is_allowed 'user' end
  before_filter :except => [:show] do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [:new, :create] do |c| c.correct_company 'company' end

	#-----------------------------------------------------------------------------------------

  def show
		# If company ID is added, then find the company, otherwise show current user company
  	if params[:id]
  		@company = Company.find(params[:id])
  	else
	    @company = Company.find(current_user.company.id)
	  end
  end

  def new
    @company = Company.new
  	@company.build_subscription
    @countries = current_user.company.countries.dropdown_list
  end
  
  def create
		@company = Company.new(params[:company])

    if @company.save
      redirect_to dashboard_url, notice: I18n.t(:message_company_created)
    else
      @countries = current_user.company.countries.dropdown_list
      render :action => "new"
    end
  end

  def edit
    @company = Company.find(params[:id])
    @countries = current_user.company.countries.dropdown_list
  end

  def update
    @company = Company.find(params[:id])

    if @company.update_attributes(params[:company])
      redirect_to dashboard_url, :notice => I18n.t(:message_company_updated)
    else
      @countries = current_user.company.countries.dropdown_list
      render :action => "edit"
    end
    
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    redirect_to dashboard_url, :notice => I18n.t(:message_company_deleted)
  end

end
