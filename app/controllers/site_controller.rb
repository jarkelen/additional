class SiteController < ApplicationController
  # Skip authorization for public index page
  skip_filter :authenticate_user, :only => [:index]
  
  # Set authorization
  before_filter :only => [:dashboard, :company_users] do |c| c.is_allowed 'admin' end

  #-----------------------------------------------------------------------------------------
  def index
    @visitor = ""
    unless params[:email].blank?
      # Send email to myself  
      @email = params[:email]
      UserMailer.visitor_info_email(@email).deliver
    
      # Send conformation
      respond_to do |format|
        format.html { redirect_to public_home_path, notice: I18n.t(:message_public_email_sent) }
      end
    end
  end

  def support
  end
  
  def dashboard
    # Count records for dashboard info
    @nr_companies = Company.count
    @nr_users = User.count
    @nr_relations = Relation.count
    @nr_contacts = Contact.count
    @nr_tasks = Task.count
    @nr_notes = Note.count
    @nr_agreements = Agreement.count
    @nr_dossiers = Dossier.count

    # Get all companies
    @companies = Company.order("created_at DESC").includes([:subscription, :users])
  end
  
  def company_users
    @company = Company.find(params[:id])
    @company_users = User.find_all_by_company_id(params[:id])
  end
end

