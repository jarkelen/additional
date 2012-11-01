require 'spec_helper'
require 'capybara'

describe "user" do

	before(:each) do
    @company = FactoryGirl.create(:company, :name => 'Test')
  end
  
  describe "[registration]" do

    it "a basic user to a basic company" do
      subscription = FactoryGirl.create(:subscription, :company => @company, 
                                        :mod_timesheet => false, 
                                        :mod_mobility => false, 
                                        :mod_employee => false) 
      admin = FactoryGirl.create(:user, :role => 'company_admin', :company => @company)

      # Login and go to new user page
      login_user(admin)
      visit users_path
      click_link I18n.t(:users_index_newuser)
      
      # Check that for basic company a department field is available
      page.should have_selector("div", :id => 'user_depertment')
      
      # Fill in new user details
      select('Gebruiker', :from => "user_role")
      select('Nederlands', :from => "user_locale")
      fill_in 'user_first_name', :with => 'Nico'
      fill_in 'user_last_name', :with => 'Nieuw'
      fill_in 'user_email', :with => 'nico.nieuw@' + @company.name + '.nl'
      fill_in 'user_position', :with => 'Consultant'
      click_button I18n.t(:register_button)
      
      # Check result
  	  page.should have_content(I18n.t :message_user_created)
  	  page.should have_content('nico.nieuw@' + @company.name + '.nl')
  	  page.should have_content('user')
    end

    it "a full user to a fully subscribed company" do
      subscription = FactoryGirl.create(:subscription, :company => @company, 
                                        :mod_timesheet => true, 
                                        :mod_mobility => true, 
                                        :mod_employee => false) 
      department = FactoryGirl.create(:tms_department, :code => 'TST', :description => "Testafdeling", :company => @company)
      admin = FactoryGirl.create(:user, :role => 'company_admin', :company => @company)
      FactoryGirl.create(:user_mob, :user => admin)
      FactoryGirl.create(:user_tms, :user => admin)
      FactoryGirl.create(:user_emp, :user => admin)
      manager = FactoryGirl.create(:user, :role => 'user', :company => @company)
      FactoryGirl.create(:user_tms, :user => manager)

      # Login and go to new user page
      login_user(admin)
      visit users_path
      click_link I18n.t(:users_index_newuser)
      
      # Fill in new user details
      select('Gebruiker', :from => "user_role")
      select('Nederlands', :from => "user_locale")
      fill_in 'user_first_name', :with => 'Nico'
      fill_in 'user_last_name', :with => 'Nieuw'
      fill_in 'user_email', :with => 'nico.nieuw@' + @company.name + '.nl'
      fill_in 'user_position', :with => 'Consultant'
      
      # Fill in timesheet details
      select('Intern', :from => "user_user_tms_attributes_internal")
      select(department.description, :from => "user_user_tms_attributes_department")
      select(manager.full_name, :from => "user_user_tms_attributes_manager")
      select('1', :from => "user_user_tms_attributes_start_period_3i")
      select('januari', :from => "user_user_tms_attributes_start_period_2i")
      select('2012', :from => "user_user_tms_attributes_start_period_1i")

      fill_in 'user_user_tms_attributes_holiday', :with => '27'
      fill_in 'user_user_tms_attributes_bonus_from', :with => '1600'
      
      # Fill in mobility details
      select('Lease', :from => "user_user_mob_attributes_car_type")
      fill_in 'user_user_mob_attributes_private_km', :with => '13500'
      click_button I18n.t(:register_button)
      
      # Check result
  	  page.should have_content(I18n.t :message_user_created)
  	  page.should have_content('nico.nieuw@' + @company.name + '.nl')
  	  page.should have_content('user')
    end

  end

	describe "an invalid user" do

		it "gets no access to the website with empty credentials" do
			visit login_path
			fill_in 'email', :with => '' 
      fill_in 'password', :with => '' 
      click_button I18n.t(:login_title)

			page.should have_content(I18n.t :session_invalid) 
		end

		it "gets no access to the website with invalid credentials" do
			visit login_path
			fill_in 'email', :with => 'invalid' 
      fill_in 'password', :with => 'invalid' 
      click_button I18n.t(:login_title)

			page.should have_content(I18n.t :session_invalid) 
		end

	end

	describe "employed user" do

		it "an employee gets no access when leave date has been reached" do
      subscription = FactoryGirl.create(:subscription, :company => @company, :mod_timesheet => true) 
      user = FactoryGirl.create(:user, :role => 'customer', :company => @company)
      FactoryGirl.create(:user_tms, :user => user, :leave_period => 1.month.ago)
      
      login_user(user)
			page.should have_content(I18n.t :session_invalid) 
		end

		it "an employee gets access when leave date has not been reached yet" do
      subscription = FactoryGirl.create(:subscription, :company => @company, :mod_timesheet => true) 
      user = FactoryGirl.create(:user, :role => 'customer', :company => @company)
      FactoryGirl.create(:user_tms, :user => user, :leave_period => 1.month.from_now)
      
      login_user(user)
			page.should have_content(I18n.t :dashboard_title)
			page.should have_content(I18n.t :session_logged_in) 
    end
    
		it "an user gets access when company not subscribed to timesheet" do
      subscription = FactoryGirl.create(:subscription, :company => @company, :mod_timesheet => false) 
      user = FactoryGirl.create(:user, :role => 'customer', :company => @company)
		  
      login_user(user)
			page.should have_content(I18n.t :dashboard_title)
			page.should have_content(I18n.t :session_logged_in) 
		end

  end
  
  describe "password reset" do
    before :each do
      subscription = FactoryGirl.create(:subscription, :company => @company, :mod_timesheet => true) 
      @user_to_change = FactoryGirl.create(:user, :role => 'customer', :company => @company)
      @department = FactoryGirl.create(:tms_department, :code => 'TST', :description => "Testafdeling", :company => @company)
      FactoryGirl.create(:user_tms, :user => @user_to_change, :department => @department)
    end
    
    it "an admin has an option to reset an users password" do
      admin = FactoryGirl.create(:user, :role => 'admin', :company => @company)
      FactoryGirl.create(:user_tms, :user => admin, :department => @department)
      
      login_user(admin)
      visit edit_user_path(@user_to_change)

			page.should have_content(I18n.t :subscription_reset)
			page.should have_selector('input', :id =>'user_password')
			
			fill_in 'user_password', :with => 'password2'
      select(@department.description, :from => "user_user_tms_attributes_department")
      click_button I18n.t(:register_button)

  	  page.should have_content(I18n.t :message_user_updated)
    end
    
    it "a company admin doesn't have an option to reset an users password" do
      company_admin = FactoryGirl.create(:user, :role => 'company_admin', :company => @company)
      FactoryGirl.create(:user_tms, :user => company_admin)
      
      login_user(company_admin)
      visit edit_user_path(@user_to_change)

			page.should_not have_content(I18n.t :subscription_reset)
    end

    it "a manager isn't allowed to edit an users profile" do
      manager = FactoryGirl.create(:user, :role => 'user', :company => @company)
      FactoryGirl.create(:user_tms, :user => manager)
      
      login_user(manager)
      visit edit_user_path(@user_to_change)

			page.should_not have_content(I18n.t :subscription_reset)
    end

    it "an employee isn't allowed to edit an users profile" do
      employee = FactoryGirl.create(:user, :role => 'customer', :company => @company)
      FactoryGirl.create(:user_tms, :user => employee)
      
      login_user(employee)
      visit edit_user_path(@user_to_change)

			page.should_not have_content(I18n.t :subscription_reset)
    end
    
  end
end
