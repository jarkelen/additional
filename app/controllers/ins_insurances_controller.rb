class InsInsurancesController < ApplicationController
	# Set authorization
	before_filter do |c| c.is_allowed 'user' end
	before_filter :only => [ :settings ] do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :index, :new, :create, :settings ] do |c| c.correct_company 'ins_insurance' end

	# Set module authorization
	before_filter do |c| c.correct_module 'ins_insurance' end

	#-----------------------------------------------------------------

	def index
		if params[:filter]
			@extra_info = I18n.t(:mod_ins_filtered)
			@insurances = current_user.company.ins_insurances.filter(params)
			@csv_insurances = @insurances
		else
			@insurances = current_user.company.ins_insurances.where(status: "actief").order("insurance_nr ASC")
			@csv_insurances = @insurances
		end

		# Get all data for filter selects
		@relations = current_user.company.relations
		@branches = current_user.company.ins_branches
		@insurance_types = current_user.company.ins_types

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
	  @markets = InsMarket.all(:conditions => ["company_id = ?", current_user.company_id])
	  @branches = InsBranch.all(:conditions => ["company_id = ?", current_user.company_id])
	  @types = InsType.all(:conditions => ["company_id = ?", current_user.company_id])
  end

  def create
	  # Get all params
	  @insurance = InsInsurance.new(params[:ins_insurance])

    # Also create an update
		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_insurance} '#{@insurance.insurance_type}' #{I18n.t :update_new}")

	  # Save the new insurance
	  if @insurance.save
		  redirect_to ins_insurance_path(@insurance), notice: I18n.t(:message_insurance_created)
	  else
		  @relations = current_user.company.relations.order(:name)
		  @markets = InsMarket.all(:conditions => ["company_id = ?", current_user.company_id])
		  @branches = InsBranch.all(:conditions => ["company_id = ?", current_user.company_id])
		  @types = InsType.all(:conditions => ["company_id = ?", current_user.company_id])
		  render action: "new"
	  end

	end

  def edit
	  @insurance = InsInsurance.find(params[:id])
	  @relations = current_user.company.relations.order(:name)
	  @markets = InsMarket.all(:conditions => ["company_id = ?", current_user.company_id])
	  @branches = InsBranch.all(:conditions => ["company_id = ?", current_user.company_id])
	  @types = InsType.all(:conditions => ["company_id = ?", current_user.company_id])
  end

  def update
	  # Get all params
	  @insurance = InsInsurance.find(params[:id])

    # Also create an update
		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_insurance} '#{@insurance.insurance_type}' #{I18n.t :update_edit}")

		if @insurance.update_attributes(params[:ins_insurance])
			redirect_to ins_insurance_path(@insurance), notice: I18n.t(:message_insurance_updated)
		else
			@relations = current_user.company.relations.order(:name)
			@markets = InsMarket.all(:conditions => ["company_id = ?", current_user.company_id])
			@branches = InsBranch.all(:conditions => ["company_id = ?", current_user.company_id])
			@types = InsType.all(:conditions => ["company_id = ?", current_user.company_id])
			render :action => "edit"
		end
  end

  def destroy
	  @insurance = InsInsurance.find(params[:id])
	  @insurance.destroy

    # Also create an update
		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_insurance} '#{@insurance.insurance_type}' #{I18n.t :update_delete}")

		redirect_to ins_insurances_path, :notice => I18n.t(:message_insurance_deleted)
  end

	def settings
		if params[:area] == "branch"
			@branches = InsBranch.all(:conditions => ["company_id = ?", current_user.company_id])
			@branch = InsBranch.new
			@active = "branch"
		elsif params[:area] == "type"
			@branches = InsBranch.all(:conditions => ["company_id = ?", current_user.company_id])
			@types = InsType.all(:conditions => ["company_id = ?", current_user.company_id])
			@type = InsType.new
			@active = "type"
		elsif params[:area] == "market"
			@markets = InsMarket.all(:conditions => ["company_id = ?", current_user.company_id])
			@market = InsMarket.new
			@active = "market"
		else
			@branches = InsBranch.all(:conditions => ["company_id = ?", current_user.company_id])
			@branch = InsBranch.new
			@active = "branch"
		end

		respond_to do |format|
			format.html
			format.js
		end
	end


end
