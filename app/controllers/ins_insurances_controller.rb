class InsInsurancesController < ApplicationController
	# Set authorization
	before_action do |c| c.is_allowed 'user' end
	before_action only: [ :settings ] do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_action except: [ :index, :new, :create, :settings ] do |c| c.correct_company 'ins_insurance' end

	# Set module authorization
	before_action do |c| c.correct_module 'ins_insurance' end

	#-----------------------------------------------------------------

	def index
		@search = current_user.company.ins_insurances.search(params[:q])
    @insurances = @search.result

		# Get all data for filter selects
		@relations = current_user.company.relations
		@branches = current_user.company.ins_branches
		@insurance_types = current_user.company.ins_types
		@insurers = current_user.company.ins_insurers
		@mediators = current_user.company.ins_mediators

		respond_to do |format|
			format.html
			format.csv
		end
	end

  def show
	  @insurance = InsInsurance.find(params[:id])
  end

  def new
	  @insurance = InsInsurance.new
	  @relations = current_user.company.relations.order(:name)
	  @markets = InsMarket.where(company_id: current_user.company_id)
	  @branches = InsBranch.where(company_id: current_user.company_id)
	  @types = InsType.where(company_id: current_user.company_id)
	  @insurers = InsInsurer.where(company_id: current_user.company_id)
	  @mediators = InsMediator.where(company_id: current_user.company_id)
  end

  def create
	  # Get all params
	  @insurance = InsInsurance.new(ins_insurances_params)

    # Also create an update
		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_insurance} '#{@insurance.insurance_type}' #{I18n.t :update_new}")

	  # Save the new insurance
	  if @insurance.save
		  redirect_to ins_insurance_path(@insurance), notice: I18n.t(:message_insurance_created)
	  else
		  @relations = current_user.company.relations.order(:name)
		  @markets = InsMarket.where(company_id: current_user.company_id)
		  @branches = InsBranch.where(company_id: current_user.company_id)
		  @types = InsType.where(company_id: current_user.company_id)
		  @insurers = InsInsurer.where(company_id: current_user.company_id)
		  @mediators = InsMediator.where(company_id: current_user.company_id)

		  render action: "new"
	  end

	end

  def edit
	  @insurance = InsInsurance.find(params[:id])
	  @relations = current_user.company.relations.order(:name)
	  @markets = InsMarket.where(company_id: current_user.company_id)
	  @branches = InsBranch.where(company_id: current_user.company_id)
	  @types = InsType.where(company_id: current_user.company_id)
	  @insurers = InsInsurer.where(company_id: current_user.company_id)
	  @mediators = InsMediator.where(company_id: current_user.company_id)
  end

  def update
	  # Get all params
	  @insurance = InsInsurance.find(params[:id])

    # Also create an update
		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_insurance} '#{@insurance.insurance_type}' #{I18n.t :update_edit}")

		if @insurance.update_attributes(ins_insurances_params)
			redirect_to ins_insurance_path(@insurance), notice: I18n.t(:message_insurance_updated)
		else
			@relations = current_user.company.relations.order(:name)
		  @markets = InsMarket.where(company_id: current_user.company_id)
		  @branches = InsBranch.where(company_id: current_user.company_id)
		  @types = InsType.where(company_id: current_user.company_id)
		  @insurers = InsInsurer.where(company_id: current_user.company_id)
		  @mediators = InsMediator.where(company_id: current_user.company_id)

			render action: "edit"
		end
  end

  def destroy
	  @insurance = InsInsurance.find(params[:id])
	  @insurance.destroy

    # Also create an update
		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_insurance} '#{@insurance.insurance_type}' #{I18n.t :update_delete}")

		redirect_to ins_insurances_path, notice: I18n.t(:message_insurance_deleted)
  end

	def settings
		if params[:area] == "branch"
			@branches = InsBranch.where(company_id: current_user.company_id).order(:branch)
			@branch = InsBranch.new
			@active = "branch"
		elsif params[:area] == "type"
			@branches = InsBranch.where(company_id: current_user.company_id)
			@types = InsType.where(company_id: current_user.company_id).order(:ins_type)
			@type = InsType.new
			@active = "type"
		elsif params[:area] == "market"
			@markets = InsMarket.where(company_id: current_user.company_id).order(:market)
			@market = InsMarket.new
			@active = "market"
		elsif params[:area] == "insurer"
			@insurers = InsInsurer.where(company_id: current_user.company_id).order(:insurer)
			@insurer = InsInsurer.new
			@active = "insurer"
		elsif params[:area] == "mediator"
			@mediators = InsMediator.where(company_id: current_user.company_id).order(:mediator)
			@mediator = InsMediator.new
			@active = "mediator"
		else
			@branches = InsBranch.where(company_id: current_user.company_id)
			@branch = InsBranch.new
			@active = "branch"
		end

		respond_to do |format|
			format.html
			format.js
		end
	end

  private

  def ins_insurances_params
    params.require(:ins_insurance).permit(:insurance_nr, :branch, :insurance_type, :market, :start_date, :duration,
									:first_contract_expiration_date, :main_premium_expiration_date,
									:extension, :payment_continuation, :arrear_calculation, :attachment_1,
									:attachment_2, :attachment_3, :relation_id, :company_id, :status, :end_date, :collection, :insurer, :mediator)
  end


end
