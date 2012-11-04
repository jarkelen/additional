class RelationsController < ApplicationController
	# Set user authorization
  before_filter :except => [:destroy] do |c| c.is_allowed 'user' end
  before_filter :only => [:destroy] do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter :except => [ :index, :new, :create ] do |c| c.correct_company 'relation' end

	#----------------------------------------------------------------------------------------

  def index
  	# Search or filter request to find specific relations, otherwise show all relations
  	if params[:search]
  		@extra_info = params[:search]
      @relations = current_user.company.relations.search(params[:search])
      @csv_relations = @relations
	  elsif params[:filter]
      @extra_info = I18n.t(:mod_inv_filtered)
      @relations = current_user.company.relations.filter(params)
		  @csv_relations = @relations
    elsif params[:conditions]
			# Find filtered relations for csv
		  @csv_relations = current_user.company.relations.all(:order => "relation_nr ASC", :conditions => params[:conditions])
	  else
      # Only show active relations by default
		  @relations = current_user.company.relations.where("status = 'actief'").order("relation_nr ASC")
      @csv_relations = current_user.company.relations
		end

	  # Get all data for filter selects
	  @filter_relations = current_user.company.relations.all

    # Get all relation markers
    @relation_markers = current_user.company.relations.to_gmaps4rails

	  respond_to do |format|
      format.csv
      format.html
      format.js
    end

  end

  def show
    @relation = current_user.company.relations.find(params[:id])
    @company_contact = User.find(@relation.company_contact)

    # Get all alphabet letters
    @letter_array = Contact.set_alphabet_letters

    # Determine last name letters of this relation's contacts
    @contact_array = Contact.get_lastname_letters(@relation.contacts)

    # Show relation's contacts
    @contacts = @relation.contacts.get_contacts(params)
  end

  def new
    @relation = Relation.new
    @relationgroups = Relation.uniq.pluck(:relationgroup)

    # Set listbox data
    get_listbox_data    
  end

  def create
    @relation = Relation.new(params[:relation])

    # Set new relation number
    @relation.relation_nr = Relation.get_company_code(current_user) + Relation.get_new_relation_nr(current_user)

    if @relation.save
      # Create an update
      Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_relation} '#{@relation.name}' #{I18n.t :update_new}")

      redirect_to relations_path, notice: I18n.t(:message_relation_created)
    else
      # Something went wrong, so get data again to show form
      @sectors = current_user.company.sectors.order(:sector)

      # Set listbox data
      get_listbox_data    

      render action: "new"
    end
  end

  def edit
    @relation = current_user.company.relations.find(params[:id])

    # Set listbox data
    get_listbox_data    
  end

  def update
    @relation = current_user.company.relations.find(params[:id])
 
    if @relation.update_attributes(params[:relation])
      # Create an update
      Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_relation} '#{@relation.name}' #{I18n.t :update_edit}")

      redirect_to relations_path, :notice => I18n.t(:message_relation_updated)
    else
      # Set listbox data
      get_listbox_data    

      render :action => "edit"
    end
  end

  def destroy
    @relation = current_user.company.relations.find(params[:id])
    @relation.destroy

    # Also create an update
    Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_relation} '#{@relation.name}' #{I18n.t :update_delete}")

    redirect_to relations_path, :notice => I18n.t(:message_relation_deleted)
  end

  #------------------------------------------------------------------------

  # Get all data to fill listboxes in relation form
  def get_listbox_data
    @countries = current_user.company.countries.dropdown_list
    @sectors = current_user.company.sectors.order(:sector)
    @rel_types = current_user.company.rel_types.dropdown_list
    @relationgroups = current_user.company.relations.dropdown_list
  end

end
