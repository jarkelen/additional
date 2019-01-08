class CompaniesController < ApplicationController
	# Set authorization
  before_action only: [ :show ] do |c| c.is_allowed 'user' end
  before_action except: [:show] do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_action except: [:new, :create] do |c| c.correct_company 'company' end

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
		@company = Company.new(company_params)

    if @company.save
      redirect_to dashboard_url, notice: I18n.t(:message_company_created)
    else
      @countries = current_user.company.countries.dropdown_list
      render action: "new"
    end
  end

  def edit
    @company = Company.find(params[:id])
    @countries = current_user.company.countries.dropdown_list
  end

  def update
    @company = Company.find(params[:id])

    if @company.update_attributes(company_params)
      redirect_to dashboard_url, notice: I18n.t(:message_company_updated)
    else
      @countries = current_user.company.countries.dropdown_list
      render action: "edit"
    end

  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    redirect_to dashboard_url, notice: I18n.t(:message_company_deleted)
  end

  private

  def company_params
    params.require(:company).permit(:name, :address1, :address2, :zipcode, :city, :country, :email, :website,
                  :telephone, :facebook, :twitter, :linkedin, :code,
                  :subscription_attributes, :kvk_nr, :bankaccount, :billing_address,
                  :billing_zipcode, :billing_city, :billing_country,
                  :post_address, :post_zipcode, :post_city, :post_country, :tax_nr, :logo,
                  subscription_attributes: [:name, :discount, :start_date, :billing_period, :user_price, :active, :company_id])
  end

end
