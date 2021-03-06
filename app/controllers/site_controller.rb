class SiteController < ApplicationController
  # Skip authorization for public index page
  skip_before_action :authenticate_user, only: [:index]

  # Set authorization
  before_action only: [:dashboard, :company_users] do |c| c.is_allowed 'admin' end

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

    # Get all companies
    @companies = Company.order("created_at DESC").includes([:subscription, :users])
  end

  def company_users
    @company = Company.find(params[:id])
    @company_users = User.where(company_id: params[:id])
  end
end
