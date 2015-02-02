class TasksController < ApplicationController
	# Set user authorization
  before_filter do |c| c.is_allowed 'user' end

	# Set berlin wall
	before_filter except: [ :index, :create ] do |c| c.correct_company 'task' end

	#-----------------------------------------------------------------------------------------

  def index
  	if params[:search]
  		@extra_info = params[:search]
			@tasks = current_user.company.tasks.order("due_at ASC").where("task_type LIKE ? OR task LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
		else
			@tasks = current_user.company.tasks.order("due_at ASC")
		end
  end

  def create
    @task = Task.new(tasks_params)

    respond_to do |format|
      if @task.save
        # Also create an update
        Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_task} '#{@task.task}' #{I18n.t :update_new}")

        @tasks = @contact.tasks.order("due_at ASC")
        @task = Note.new

        format.js
      else
        @contact = Contact.find(params[:task][:contact_id])
        @tasktypes = Tasktype.dropdown_list
        @users = User.dropdown_list(current_user)

        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @task = current_user.company.tasks.find(params[:id])
    @task.destroy

    # Get all remaining tasks, based on context
    if params[:context] == "contacts"
      # Specific contact tasks
      @contact = Contact.find(@task.contact_id)
      @tasks = @contact.tasks.order("due_at ASC")
    elsif params[:context] == "tasks"
      # All tasks of company
			@tasks = current_user.company.tasks.order("due_at ASC")
    else
      # Current user's tasks on dashboard
      @tasks = current_user.tasks.order("due_at ASC")
    end

    # Also create an update
    Activity.create_update(current_user, "#{current_user.full_name} #{I18n.t :update_task} '#{@task.task}' #{I18n.t :update_delete}")

    respond_to do |format|
      format.js
    end
  end

  private

  def tasks_params
    params.require(:task).permit(:task_type, :task, :due_at, :user_id, :contact_id)
  end

end
