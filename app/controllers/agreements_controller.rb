class AgreementsController < ApplicationController
	# Set user authorization
  before_filter do |c| c.is_allowed 'user' end

	# Set berlin wall
	before_filter :except => [ :index, :create ] do |c| c.correct_company 'agreement' end

	#-----------------------------------------------------------------------------------------

  def index
  	if params[:search]
  		@extra_info = params[:search]
			@agreements = current_user.company.agreements.order("updated_at DESC").where('agreement LIKE ?', "%#{params[:search]}%")
		else
			@agreements = current_user.company.agreements.order("updated_at DESC")
		end
		
		# Show link to contact
		@show_contact = true
  end
  
  def create
    @agreement = Agreement.new(agreement_params)
    @contact = Contact.find(params[:agreement][:contact_id])

    respond_to do |format|
      if @agreement.save
        # Also create an update
        Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_agreement} '#{@agreement.agreement}' #{I18n.t :update_new}")

        @agreements = @contact.agreements.order("updated_at DESC")
        @agreement = Agreement.new

        format.js
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @agreement = current_user.company.agreements.find(params[:id])

    # Also create an update
    Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_agreement} '#{@agreement.agreement}' #{I18n.t :update_edit}")

    respond_to do |format|
      if @agreement.update_attributes(agreement_params)
        format.html { redirect_to "/contacts/" + @agreement.contact.id.to_s, notice: I18n.t(:message_agreement_updated) }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @agreement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /agreements/1
  def destroy
    @agreement = current_user.company.agreements.find(params[:id])
    @agreement.destroy

    # Get all remaining tasks, based on context
    if params[:context] == "contacts"
      @contact = Contact.find(@agreement.contact_id)
      @agreements = @contact.agreements.order("updated_at DESC")
    elsif params[:context] == "agreements"
			@agreements = current_user.company.agreements.order("updated_at DESC")
    end

    # Also create an update
    Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_agreement} '#{@agreement.agreement}' #{I18n.t :update_delete}")

    respond_to do |format|
      format.js
    end
  end

  private
  
  def agreement_params
    params.require(:agreement).permit(:agreement, :contact_id, :user_id)
  end
  
end
