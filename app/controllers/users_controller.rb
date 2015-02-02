class UsersController < ApplicationController
  skip_filter :authenticate_user

	# Set authorization
  before_filter except: [ :show, :edit, :update ] do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter except: [ :index, :new, :create, :settings ] do |c| c.correct_company 'user' end

	# Check for correct user
	before_filter do |c| c.correct_module 'user' end

	#----------------------------------------------------------------------------------------

  def index
   	if params[:id] == "country"
    	@countries = Country.where(company_id: current_user.company.id)
    	@country = Country.new
    	@active = "country"
   	elsif params[:id] == "sector"
    	@sectors = Sector.where(company_id: current_user.company.id)
    	@sector = Sector.new
    	@active = "sector"
   	elsif params[:id] == "branch"
    	@branches = Branch.where(company_id: current_user.company.id)
    	@branch = Branch.new
    	@active = "branch"
   	elsif params[:id] == "sector"
    	@sectors = Sector.where(company_id: current_user.company.id)
    	@sector = Sector.new
    	@active = "sector"
   	elsif params[:id] == "tasktype"
    	@tasktypes = Tasktype.where(company_id: current_user.company.id)
    	@tasktype = Tasktype.new
    	@active = "tasktype"
   	elsif params[:id] == "rel_type"
    	@rel_types = RelType.where(company_id: current_user.company.id)
    	@rel_type = RelType.new
    	@active = "rel_type"
		else
	    @users = current_user.company.users.order("last_name")
	    @countries = Country.where(company_id: current_user.company.id)
	    @country = Country.new
    	@active = "country"
		end

    respond_to do |format|
      format.html
	    format.js
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
	  # Get all companies for admin to assign user to
	  if current_user.allowed?('admin')
  		@companies = Company.all
  	end

    # Create new user
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(users_params)

    # Get all companies for admin to assign user to
    if current_user.allowed?('admin')
		  @companies = Company.all
	  end

    # Create user
    if @user.save
      # Inform admin that user has been added
	    UserMailer.registration_inform_admin(@user).deliver

	    # Send email to user when field is enabled
  	  if current_user.allowed?('admin') && params[:send_email] == "1"
		    UserMailer.registration_confirmation(@user).deliver
	    end

      # Also create an update
  		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_user} '#{@user.full_name}' #{I18n.t :update_new}")

	    # Show user details
	    redirect_to user_path(@user), notice: I18n.t(:message_user_created)
    else
      render action: "new"
    end
  end

  def edit
	  # Get all companies for admin to assign user to
	  if current_user.allowed?('admin')
		  @companies = Company.all
	  end

	  @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

		# Get all companies for admin to assign user to
	  if current_user.allowed?('admin')
		  @companies = Company.all
	  end

    if @user.update_attributes(users_params)
	    # Send email to user when field is enabled
	    if current_user.allowed?('admin') && params[:send_email_to_user] == "1"
		    UserMailer.registration_confirmation(@user).deliver
	    end

	    # Send email to admin when field is enabled
	    if current_user.allowed?('admin') && params[:send_email_to_admin] == "1"
  	    UserMailer.registration_inform_admin(@user).deliver
	    end

      # Also create an update
  		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_user} '#{@user.full_name}' #{I18n.t :update_edit}")

	    redirect_to user_path(@user), notice: I18n.t(:message_user_updated)
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    # Also create an update
		Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_user} '#{@user.full_name}' #{I18n.t :update_delete}")

    redirect_to dashboard_path, notice: I18n.t(:message_user_deleted)
  end


  private

	# If current user is a regular user or subco, it isn't allowed to see other user data
	def correct_user
		if current_user.allowed?('user') || current_user.allowed?('customer')
      @user = User.find(params[:id])
      if current_user != @user
				flash[:alert] = I18n.t(:not_allowed)
      	redirect_to root_path
      end
		end
	end

  def users_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :password, :position, :department,
                  :locale, :role, :sign_in_count, :last_sign_in_at, :mod_platform, :mod_insurance, :mod_claim,
                  :company, :company_id)
  end

end
