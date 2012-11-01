class DossiersController < ApplicationController
	# Set user authorization
  before_filter do |c| c.is_allowed 'user' end

	# Set berlin wall
	before_filter :except => [ :index, :new, :create ] do |c| c.correct_company 'dossier' end

	#----------------------------------------------------------------------------------------

  def index
  	if params[:search]
  		@extra_info = params[:search]
			@dossiers = current_user.company.dossiers.order("updated_at DESC").where('title LIKE ?', "%#{params[:search]}%")
		else
			@dossiers = current_user.company.dossiers.order("updated_at DESC")
		end
  end

  def show
    @dossier = current_user.company.dossiers.find(params[:id])   
    
    # Get additional data based on tab clicked
   	if params[:tab] == "general" || params[:tab] == nil
      @dossier_contacts = @dossier.contacts.order("last_name ASC")
   	  @active = "general"
    elsif params[:tab] == "contacts"
      @dossier_contacts = @dossier.contacts.order("last_name ASC")
     	@active = "contacts"
   	elsif params[:tab] == "tasks"
      @dossier_tasks = @dossier.tasks.order("due_at ASC")
   	  @active = "tasks"
   	elsif params[:tab] == "notes"
      @dossier_notes = @dossier.notes.order("created_at DESC")
   	  @active = "notes"
   	elsif params[:tab] == "agreements"
      @dossier_agreements = @dossier.agreements.order("updated_at DESC")
   	  @active = "agreements"
    end

    respond_to do |format|
      format.html
      format.js
    end

  end
 
  def new
    @dossier = Dossier.new

    # Get listbox data
    get_listbox_data
  end
 
  def create
    @dossier = Dossier.new(params[:dossier])

    # Get listbox data
    get_listbox_data

    if @dossier.save
      # Also create an update
      Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_dossier} '#{@dossier.title}' #{I18n.t :update_new}")

      redirect_to dossiers_path, notice: I18n.t(:message_dossier_created)
    else
      render action: "new"
    end
  end

  def edit
    @dossier = current_user.company.dossiers.find(params[:id])

    # Get listbox data
    get_listbox_data
  end

  def update
    @dossier = current_user.company.dossiers.find(params[:id])

    # Get listbox data
    get_listbox_data

    if @dossier.update_attributes(params[:dossier])
      # Also create an update
      Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_dossier} '#{@dossier.title}' #{I18n.t :update_edit}")

      redirect_to dossiers_path, notice: I18n.t(:message_dossier_updated)
    else
      render :action => "edit"
    end
  end

  def destroy
    @dossier = current_user.company.dossiers.find(params[:id])
    @dossier.destroy

    # Also create an update
    Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_dossier} '#{@dossier.title}' #{I18n.t :update_delete}")

    redirect_to dossiers_path, notice: I18n.t(:message_dossier_deleted)
  end

  #------------------------------------------------------------------------

  # Get all listbox data to fill form
  def get_listbox_data
    @dossier_statuses = DossierStatus.dropdown_list
  end

end
