require 'spec_helper'
require 'capybara'

describe "task" do

  before :each do
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company) 
    @user = FactoryGirl.create(:user, 
                               :role => 'company_admin', 
                               :company => @company)
    FactoryGirl.create(:user_tms, :user => @user)
    @relation = FactoryGirl.create(:relation, :company => @company)
    @contact = FactoryGirl.create(:contact, :relation => @relation) 
      
    login_user(@user)
  end
  
  describe "INDEX show all tasks" do

    it "shows the title" do
      visit tasks_url
      page.should have_content(I18n.t :task_index_title)
    end

    it "shows the tasks" do
      @task_a = FactoryGirl.create(:task, 
                                   :task => "Task A", 
                                   :user => @user, 
                                   :contact => @contact) 
      @task_b = FactoryGirl.create(:task, 
                                   :task => "Task B", 
                                   :user => @user, 
                                   :contact => @contact) 

      visit tasks_url
      page.should have_content(@task_a.task)
      page.should have_content(@task_a.user.full_name)
      page.should have_content(@task_b.task)
      page.should have_content(@task_b.user.full_name)
    end
  end
end
