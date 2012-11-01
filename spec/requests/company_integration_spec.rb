require 'spec_helper'
require 'capybara'

describe "company" do

	before(:each) do
	  # Create uber company and admin to create other companies 
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company, 
                                      :mod_timesheet => false, 
                                      :mod_employee => false, 
                                      :mod_mobility => false)
    @admin = FactoryGirl.create(:user, :role => 'admin', :company => @company, 
                                :mod_timesheet => false, 
                                :mod_declaration => false,
                                :mod_mobility => false,
                                :mod_platform => false,
                                :mod_invoice => false,
                                :mod_insurance => false,
                                :mod_employee => false,
                                :mod_marketplace => false)
  end

  #------------------------------------------------------------------------------------------------------------
  #  CRUD
  #------------------------------------------------------------------------------------------------------------

  describe "[crud]" do

  	before(:each) do
      login_user(@admin)
    end
  
    describe "[index]" do
      it "shows all companies" do
        company_b = FactoryGirl.create(:company, :name => 'Company B')
        subscription = FactoryGirl.create(:subscription, :company => company_b, :mod_timesheet => false)
        
        visit dashboard_path

    	  page.should have_content(company_b.name)
    	  page.should have_content(I18n.t :company_all)
      end
    end

    describe "[add]" do
      it "adds a new company" do
        company_b = FactoryGirl.create(:company, :name => 'Company B')
        subscription = FactoryGirl.create(:subscription, :company => company_b, :mod_timesheet => false)

        visit company_path(company_b)

    	  page.should have_content(company_b.name)
    	  page.should have_content(I18n.t :company_show_title)
      end
    end

    describe "[edit]" do
      it "edits a company" do
        company_b = FactoryGirl.create(:company, :name => 'Company B')
        subscription = FactoryGirl.create(:subscription, :company => company_b, :mod_timesheet => false)

        # Change company
        visit edit_company_path(company_b)
        fill_in 'company_name', :with => 'Company C'
        click_button I18n.t(:form_save_button)

        # Check created company
    	  page.should have_content('Company C')
    	  page.should have_content(I18n.t :company_all)
      end
    end

    describe "[edit]" do
      it "edits a company" do
        company_b = FactoryGirl.create(:company, :name => 'Company B')
        subscription = FactoryGirl.create(:subscription, :company => company_b, :mod_timesheet => false)

        visit company_path(company_b)

        # Check created company
    	  page.should have_content(company_b.name)
    	  page.should have_content(I18n.t :company_show_title)
      end
    end

    pending "[destroy]" do
      it "removes a company" do
        company_b = FactoryGirl.create(:company, :name => 'Company B')
        subscription = FactoryGirl.create(:subscription, :company => company_b, :mod_timesheet => false, :mod_employee => false)

        # Delete company
        visit dashboard_path
        save_and_open_page
        click_link(I18n.t :delete)
        

        # Check created company
#    	  page.should have_content(company_b.name)
#    	  page.should have_content(I18n.t :company_show_title)
      end
    end
  end

end
