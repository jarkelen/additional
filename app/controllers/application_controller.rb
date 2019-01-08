class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :is_allowed_to_view

  # Users must always login first
  before_action :authenticate_user

  # Determine locale based on user profile
  before_action :set_locale

  # Show recent activities in side bar
  before_action :recent_activities

  # Set current user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Sets the locale
  def set_locale
  	# Only get locale when a user is logged in, otherwise use default locale
  	if current_user
      I18n.locale = current_user.locale
    else
      I18n.locale = I18n.default_locale
    end
  end

  # Show recent activities
  def recent_activities
  	# Only get recent activities when a user is logged in
  	if current_user
      @activities = Activity.where("company_id = ?", current_user.company.id).limit(10).order("created_at DESC")
		end
  end


  # MOVE TO MODEL INVOICE AFTER REFACTORING
  def add_leading_zeros(nr)
    # Determine leading zeros
    nr_zeros = 4 - nr.to_s.length
    counter = 0
    zeros = ""
    while counter < nr_zeros
      zeros = zeros + "0"
      counter = counter + 1
    end
    nr = zeros + nr.to_s
    return nr
  end

  # Check if current user is allowed to request the module
	def correct_module(check_module)
		if check_module == "ins_insurance"
			unless current_user.mod_insurance
				flash[:alert] = I18n.t(:not_allowed)
				redirect_to users_dashboard_path
			end
		end
	end

  def is_allowed(required_level)
  	# Required level is level and all levels above (1=high, 3=low)
  	# level 1: subco
  	# level 2: user
  	# level 3: company_admin
  	# level 4: admin
  	case required_level
  		when 'user'
		    unless current_user.role == 'user' || current_user.role == 'company_admin' || current_user.role == 'admin'
		      flash[:alert] = I18n.t(:not_allowed)
		      redirect_to users_dashboard_path
		    end
  		when 'company_admin'
		    unless current_user.role == 'company_admin' || current_user.role == 'admin'
		      flash[:alert] = I18n.t(:not_allowed)
		      redirect_to users_dashboard_path
		    end
  		when 'admin'
		    unless current_user.role == 'admin'
		      flash[:alert] = I18n.t(:not_allowed)
		      redirect_to users_dashboard_path
		    end
		end
  end

	# REMOVE WHEN NOT USED ANYMORE, METHOD IS MOVED TO USER MODEL (allowed? method)
  def is_allowed_to_view(required_level)
  	# Required level is level and all levels above (1=high, 3=low)
  	# level 1: subco
  	# level 2: user
  	# level 3: company_admin
  	# level 4: admin
  	case required_level
  		when 'user'
		    if current_user.role == 'user' || current_user.role == 'company_admin' || current_user.role == 'admin'
		      return true
		    else
		    	return false
		    end
  		when 'company_admin'
		    if current_user.role == 'company_admin' || current_user.role == 'admin'
		      return true
		    else
		    	return false
		    end
  		when 'admin'
		    if current_user.role == 'admin'
		      return true
		    else
		    	return false
		    end
		end
  end

	# Check if the user is already logged in
	def authenticate_user
		unless session[:user_id]
      redirect_to public_home_path
		end
	end

  #------------------------------------------------------------------
  # Company security
  #------------------------------------------------------------------

  # Check if current user is performing action for his own company
	def correct_company(checktype)
		bypass_admin = false

  	case checktype
  		when 'company'
  			# Bypass check for admin
  			if current_user.role == 'admin'
	  			bypass_admin = true
				else
	  			# URL param = company_id
	  			req_company_id = params[:id].to_i
				end
  		when 'user'
  			# Bypass check for admin
  			if current_user.role == 'admin'
	  			bypass_admin = true
			  else
		  		# URL param = user_id
  				user = User.find(params[:id])
  				req_company_id = user.company_id.to_i
  			end
  		when 'relation'
  			# URL param = relation_id
  			relation = Relation.find(params[:id])
  			req_company_id = relation.company_id.to_i
  		when 'contact'
  			# URL param = contact_id
  			contact = Contact.find(params[:id])
  			req_company_id = contact.relation.company_id.to_i
  		when 'task'
  			# URL param = task_id
  			task = Task.find(params[:id])
  			req_company_id = task.contact.relation.company_id.to_i
  		when 'note'
  			# URL param = note_id
  			note = Note.find(params[:id])
  			req_company_id = note.contact.relation.company_id.to_i
  		when 'agreement'
  			# URL param = agreement_id
  			agreement = Agreement.find(params[:id])
  			req_company_id = agreement.contact.relation.company_id.to_i
  		when 'country'
  			# URL param = country_id
  			country = Country.find(params[:id])
  			req_company_id = country.company_id.to_i
  		when 'tasktype'
  			# URL param = tasktype_id
  			tasktype = Tasktype.find(params[:id])
  			req_company_id = tasktype.company_id.to_i
  		when 'rel_type'
  			# URL param = rel_type_id
  			rel_type = RelType.find(params[:id])
  			req_company_id = rel_type.company_id.to_i
  		when 'branch'
  			# URL param = branch_id
  			branch = Branch.find(params[:id])
  			req_company_id = branch.company_id.to_i
  		when 'sector'
  			# URL param = sector_id
  			sector = Sector.find(params[:id])
  			req_company_id = sector.company_id.to_i
		  when 'claim'
			  # URL param = claim_id
			  claim = Claim.find(params[:id])
			  req_company_id = claim.relation.company_id.to_i
		  when 'ins_insurance'
			  # URL param = insurance_id
			  insurance = InsInsurance.find(params[:id])
			  req_company_id = insurance.relation.company_id.to_i
		  when 'ins_branch'
			  # URL param = branch_id
			  branch = InsBranch.find(params[:id])
			  req_company_id = branch.company_id.to_i
		  when 'ins_type'
			  # URL param = type_id
			  type = InsType.find(params[:id])
			  req_company_id = type.company_id.to_i
		  when 'ins_market'
			  # URL param = branch_id
			  market = InsMarket.find(params[:id])
			  req_company_id = market.company_id.to_i
      when 'ins_insurer'
        # URL param = insurer_id
        insurer = InsInsurer.find(params[:id])
        req_company_id = insurer.company_id.to_i
      when 'ins_mediator'
        # URL param = mediator_id
        mediator = InsMediator.find(params[:id])
        req_company_id = mediator.company_id.to_i
	  end

		# Bypass admin when necessary, admin is allowed to jump the berlin wall sometimes
		unless bypass_admin
			# Check if companies are the same
			if current_user.company_id.to_i != req_company_id
				flash[:alert] = I18n.t(:not_allowed)
	    	redirect_to users_dashboard_path
	    end
		end
	end
end
