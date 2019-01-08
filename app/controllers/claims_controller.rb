class ClaimsController < ApplicationController
	# Set authorization
  before_action except: [ :destroy ] do |c| c.is_allowed 'user' end
  before_action only: [ :destroy ] do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_action except: [ :index, :new, :create] do |c| c.correct_company 'claim' end

	#----------------------------------------------------------------------------------------

	def index
		@search = current_user.company.claims.search(params[:q])
    @claims = @search.result

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
	  @claim = Claim.find(params[:id])
  end

  def new
	  @claim = Claim.new
	  @relations = current_user.company.relations.order(:name)
	  @markets = InsMarket.where(company_id: current_user.company_id)
	  @branches = InsBranch.where(company_id: current_user.company_id)
	  @types = InsType.where(company_id: current_user.company_id)
	  @insurers = InsInsurer.where(company_id: current_user.company_id)
	  @mediators = InsMediator.where(company_id: current_user.company_id)
  end

  def create
	  # Get all params
	  @claim = Claim.new(claim_params)

    # Also create an update
		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_claim} '#{@claim.id}' #{I18n.t :update_new}")

	  # Save the new claim
	  if @claim.save
		  redirect_to claim_path(@claim), notice: I18n.t(:message_claim_created)
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
	  @claim = Claim.find(params[:id])
	  @relations = current_user.company.relations.order(:name)
	  @markets = InsMarket.where(company_id: current_user.company_id)
	  @branches = InsBranch.where(company_id: current_user.company_id)
	  @types = InsType.where(company_id: current_user.company_id)
	  @insurers = InsInsurer.where(company_id: current_user.company_id)
	  @mediators = InsMediator.where(company_id: current_user.company_id)
  end

  def update
	  # Get all params
	  @claim = Claim.find(params[:id])

    # Also create an update
		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_claim} '#{@claim.id}' #{I18n.t :update_edit}")

		if @claim.update_attributes(claim_params)
			redirect_to claim_path(@claim), notice: I18n.t(:message_claim_updated)
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
	  @claim = Claim.find(params[:id])
	  @claim.destroy

    # Also create an update
		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_claim} '#{@claim.id}' #{I18n.t :update_delete}")

		redirect_to claims_path, notice: I18n.t(:message_claim_deleted)
  end

  private

  def claim_params
    params.require(:claim).permit(:claim_nr, :relation_id, :company_id)
  end

end
