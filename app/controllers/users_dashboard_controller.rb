class UsersDashboardController < ApplicationController
  def show
  	# Find all tasks of current user
    @tasks = current_user.tasks.paginate(:page => params[:page], :per_page => 6, :order => "due_at ASC")

  	# Find all dossiers of current user
    @dossiers = current_user.dossiers.paginate(:page => params[:page], :per_page => 4, :order => "created_at ASC")

    # Count records for dashboard info
    @nr_relations = current_user.company.relations.count
    @nr_contacts = current_user.company.contacts.count
    @nr_tasks = current_user.company.tasks.count
    @nr_notes = current_user.company.notes.count
    @nr_agreements = current_user.company.agreements.count
    @nr_dossiers = current_user.company.dossiers.count
  end

end
