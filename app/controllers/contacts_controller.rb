class ContactsController < ApplicationController
	# Set authorization
  before_filter except: [ :destroy ] do |c| c.is_allowed 'user' end
  before_filter only: [ :destroy ] do |c| c.is_allowed 'company_admin' end

	# Set berlin wall
	before_filter except: [ :index, :new, :create, :import, :import_data ] do |c| c.correct_company 'contact' end

	#----------------------------------------------------------------------------------------

  def index
    # Get all contacts, optionally filtered
    if params[:search]
      @contacts = current_user.company.contacts.search(params[:search])
    elsif params[:letter]
      @contacts = current_user.company.contacts.per_letter(params[:letter])
    else
      @contacts = current_user.company.contacts.order("last_name ASC")
    end

    # Set extra page title for filter requests
    if params[:letter]
      @extra_info = params[:letter]
    end

    # Get all alphabet letters
    @letter_array = Contact.set_alphabet_letters

    # Determine last name letters of this relation's contacts
    @contact_array = Contact.get_lastname_letters(@contacts)
  end

  def show
 	  @contact = current_user.company.contacts.find(params[:id])
    @users = User.dropdown_list(current_user)
    @relation = @contact.relation

    # Show all contact details or just the organigram
 	  if params[:organigram] == "true"
   	  @action = "organigram"

      # Get details of the boss of the current contact
   	  if @contact.has_boss?
   	    @boss = current_user.company.contacts.find_by_id(@contact.has_boss)
   	  end

   	  # Get all contacts who have current contact as boss
   	  @employees = current_user.company.contacts.where(has_boss: @contact)
   	else
   	  # Get additional data based on tab
     	if params[:tab] == "tasks"
        @contact_tasks = @contact.tasks.order("due_at ASC")
        @task = Task.new
        @tasktypes = Tasktype.dropdown_list
      	@active = "tasks"
     	elsif params[:tab] == "notes"
        @contact_notes = @contact.notes.order("created_at DESC")
        @note = Note.new
      	@active = "notes"
     	elsif params[:tab] == "agreements"
        @contact_agreements = @contact.agreements.order("updated_at DESC")
        @agreement = Agreement.new
        @active = "agreements"
      else
        @contact_tasks = @contact.tasks.order("due_at ASC")
        @contact_notes = @contact.notes.order("created_at ASC")
        @contact_agreements = @contact.agreements.order("created_at ASC")
        @tasktypes = Tasktype.dropdown_list
        @task = Task.new
        @active = "tasks"
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    # Create new contact when a vcard is imported
    unless params[:vcard_file].blank?
	    # Get the path info from the form
      uploaded = params[:vcard_file]
      vcard = File.new(uploaded.path)

      # Read all lines of the vcard
      line_arr = File.readlines(vcard)
      line_arr.delete_if { |line| line.match(/^.+\:.+$/).nil? }
      vcard_data = line_arr.join

      # Decode the vcard data and set the data
      card = Vpim::Vcard.decode(vcard_data).first

      # Create the new contact
      @contact = Contact.new
      @contact.email = card.email.to_s
      @contact.first_name = card.name.given.to_s
      @contact.last_name = card.name.family.to_s
      @contact.telephone_business = card.telephones[0].to_s
      @contact.telephone_private = card.telephones[1].to_s
      @contact.telephone_mobile = card.telephones[2].to_s

      flash.now[:notice] = I18n.t(:message_vcard_imported)
    else
      @contact = Contact.new
	  end

    @relations = current_user.company.relations
  end

  def create
    @contact = Contact.new(contract_params)

    if @contact.save
      redirect_to contacts_path, notice: I18n.t(:message_contact_created)

      # Also create an update
      Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_contact} '#{@contact.full_name}' #{I18n.t :update_new}")
    else
      @relations = current_user.company.relations

      render action: "new"
    end
  end

  def edit
    @contact = current_user.company.contacts.find(params[:id])
    @relations = current_user.company.relations
  end

  def update
    @contact = current_user.company.contacts.find(params[:id])

    if @contact.update_attributes(contract_params)
      # Also create an update
      Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_contact} '#{@contact.full_name}' #{I18n.t :update_edit}")

      redirect_to contacts_path, notice: I18n.t(:message_contact_updated)
    else
      render action: "edit"

      @relations = current_user.company.relations
    end
  end

  def destroy
    @contact = current_user.company.contacts.find(params[:id])
    @contact.destroy

    # Create an update
    Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_contact} '#{@contact.full_name}' #{I18n.t :update_delete}")

    redirect_to contacts_path, notice: I18n.t(:message_contact_deleted)
  end


  #---------- Vcard ------------

	def import
	  @vcard = ""
	end

	def vcard_export
		@contact = Contact.find_by_id(params[:id])

		# Create filename
		if @contact.middle_name != ""
			filename = @contact.first_name + '_' + @contact.middle_name + '_' + @contact.last_name + '.vcf'
		else
			filename = @contact.first_name + '_' + @contact.last_name + '.vcf'
		end

		card = Vpim::Vcard::Maker.make2 do |maker|
			# Set name
			maker.add_name do |name|
	    	name.given = @contact.first_name

	    	if @contact.middle_name != ""
					name.family = @contact.middle_name + ' ' + @contact.last_name
				else
					name.family = @contact.last_name
				end
			end

			if @contact.telephone_business != ""
				maker.add_tel(@contact.telephone_business)
			end

			if @contact.email != ""
				maker.add_email(@contact.email)
			end
		end

		send_data card.to_s, filename: filename
  end

  private

  def contract_params
    params.require(:contact).permit(:first_name, :middle_name, :last_name, :function,
                  :telephone_business, :telephone_private, :telephone_mobile,
                  :email, :facebook, :twitter, :linkedin, :salutation, :gender,
                  :background, :title, :birth_date, :fax, :relation_id,
                  :custom_label_1, :custom_field_1, :custom_label_2, :custom_field_2,
                  :custom_label_3, :custom_field_3, :has_boss)
  end

end
