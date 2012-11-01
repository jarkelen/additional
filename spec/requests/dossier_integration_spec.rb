require 'spec_helper'
require 'capybara'

describe "dossier" do

  before :each do
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company) 
    @user = FactoryGirl.create(:user, 
                               :role => 'company_admin', 
                               :company => @company)
    FactoryGirl.create(:user_tms, :user => @user)
      
    login_user(@user)
  end
  
  describe "INDEX show all dossiers" do
    before :each do
      @dossier_a = FactoryGirl.create(:dossier, 
                                       :company => @company, 
                                       :title => "Dossier A")
      @dossier_b = FactoryGirl.create(:dossier, 
                                       :company => @company, 
                                       :title => "Dossier B")
    end

    it "shows the dossiers" do
      visit dossiers_url

      page.should have_content(I18n.t :dossier_index_title)
      page.should have_content(@dossier_a.title)
      page.should have_content(@dossier_b.title)
    end
  end

  describe "SHOW all dossier details" do
    before :each do
      @dossier = FactoryGirl.create(:dossier, :company => @company)
    end

    it "shows the dossier details" do
      visit dossier_url(@dossier)

      page.should have_selector("a", :content => I18n.t(:dossier_all))
      page.should have_selector("a", :content => I18n.t(:form_edit_button))
      page.should have_selector("a", :content => I18n.t(:form_delete_button))

      page.should have_selector("a", :content => I18n.t(:dossier_general))
      page.should have_selector("a", :content => I18n.t(:contacts_all_short))
      page.should have_selector("a", :content => I18n.t(:task_index_title))
      page.should have_selector("a", :content => I18n.t(:notes_index_title))
      page.should have_selector("a", :content => I18n.t(:agreement_index_title))

      page.should have_content(@dossier.title)
      page.should have_content(@dossier.status)
      page.should have_content(@dossier.created_at.strftime("%d-%m-%Y"))
      page.should have_content(@dossier.updated_at.strftime("%d-%m-%Y"))
    end
  end

  describe "NEW add a new dossier" do
    it "can add a new dossier" do
      @dossier_status = FactoryGirl.create(:dossier_status) 

      visit new_dossier_url
      fill_in 'dossier_title', :with => 'Test dossier'
      select(@dossier_status.status, :from => 'dossier_status')
      fill_in 'dossier_fte', :with => '1'
      click_button I18n.t(:form_save_button)

      page.should have_content(I18n.t :message_dossier_created)
      page.should have_content("Test dossier")
      page.should have_content(@dossier_status.status)
    end
  end

  describe "EDIT change an existing dossier" do
    it "can edit a existing dossier" do
      @dossier = FactoryGirl.create(:dossier) 
      @dossier_status = FactoryGirl.create(:dossier_status) 

      visit edit_dossier_url(@dossier)

      fill_in 'dossier_title', :with => 'Changed dossier'
      click_button I18n.t(:form_save_button)

      page.should have_content(I18n.t :message_dossier_updated)
      page.should have_content("Changed dossier")
    end
  end

  describe "DELETE remove an existing dossier" do
    it "can edit a existing dossier" do
      @dossier = FactoryGirl.create(:dossier) 

      visit dossier_url(@dossier)
      click_link I18n.t :form_delete_button

      page.should have_content(I18n.t :message_dossier_deleted)
    end
  end

  describe "AUTHORIZATION" do
    before :each do
      @relation = FactoryGirl.create(:relation, :company => @company)
    end

    it "shows a remove button for admins" do
      visit relation_url(@relation)
      page.should have_content(I18n.t :form_delete_button)
    end

    it "doesn't show a remove button for managers" do
      @user = FactoryGirl.create(:user, :role => 'user', :company => @company)
      FactoryGirl.create(:user_tms, :user => @user)

      logout_and_login_user(@user)
      visit relation_url(@relation)
      page.should_not have_content(I18n.t :form_delete_button)
    end

    it "doesn't show the relations module for employees" do
      @user = FactoryGirl.create(:user, :role => 'customer', :company => @company)
      FactoryGirl.create(:user_tms, :user => @user)

      logout_and_login_user(@user)
      visit relations_url

      page.should have_content(I18n.t :not_allowed)
      page.should_not have_content(I18n.t :relations_index_title)
    end
  end      

end
