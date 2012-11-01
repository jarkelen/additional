class NotesController < ApplicationController
	# Set user authorization
  before_filter do |c| c.is_allowed 'user' end

	# Set berlin wall
	before_filter :except => [ :index, :create ] do |c| c.correct_company 'note' end

	#-----------------------------------------------------------------------------------------

  def index
  	if params[:search]
			@notes = current_user.company.notes.order("created_at DESC").where('subject LIKE ? OR note LIKE ?',  "%#{params[:search]}%",  "%#{params[:search]}%")
		else
			@notes = current_user.company.notes.order("created_at DESC")
		end
  end

  def create
    @note = Note.new(params[:note])
    @contact = Contact.find(params[:note][:contact_id])
    
    respond_to do |format|
      if @note.save
        # Also create an update
        Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_note} '#{@note.subject}' #{I18n.t :update_edit}")

        @notes = @contact.notes.order("created_at DESC")
        @note = Note.new

        format.js
      else
        @contact = Contact.find(params[:note][:contact_id])

        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @note = current_user.company.notes.find(params[:id])
    @note.destroy

    # Get all remaining notes, based on context
    if params[:context] == "notes"
      @contact = Contact.find(@note.contact_id)
      @notes = @contact.notes.order("created_at DESC")
    elsif params[:context] == "agreements"
			@notes = current_user.company.notes.order("created_at DESC")
    end

    # Also create an update
    Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_note} '#{@note.subject}' #{I18n.t :update_delete}")

    respond_to do |format|
      format.js
    end
  end
  
 
end
