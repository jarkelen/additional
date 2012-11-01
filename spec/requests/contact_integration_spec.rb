require 'spec_helper'
require 'capybara'

describe "contact" do

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
  
  describe "INDEX show all relations" do
    it "shows the relations" do
      visit contacts_url
      page.should have_content(I18n.t :contacts_index_title)
      page.should have_selector("a", :content => I18n.t(:contacts_all))
      page.should have_selector("a", :content => I18n.t(:contacts_new_title))
      page.should have_selector("a", :content => I18n.t(:contacts_new_vcard))
      page.should have_content(@contact.full_name)
     end

    it "shows the filter letters" do
      visit contacts_url
      page.should have_selector("div", :class => "letter_filter")
    end
  end

  describe "SHOW contact details" do
    it "shows the contact details" do
      visit contact_url(@contact)

      page.should have_selector("a", :content => I18n.t(:contacts_all))
      page.should have_selector("a", :content => I18n.t(:form_edit_button))
      page.should have_selector("a", :content => "vCard")
      page.should have_content(@contact.full_name)
      page.should have_content(@contact.email)
      page.should have_selector("a", :id => "organigram_link")
      page.should have_selector("ul", :class => "tabs")
      page.should have_selector("div", :class => "contact")
    end

    it "shows a remove button for admins" do
      visit contact_url(@contact)
      page.should have_content(I18n.t :form_delete_button)
    end

    it "doesn't show a remove button for managers" do
      @user = FactoryGirl.create(:user, :role => 'user', :company => @company)
      FactoryGirl.create(:user_tms, :user => @user)

      logout_and_login_user(@user)
      visit contact_url(@contact)
      page.should_not have_content(I18n.t :form_delete_button)
    end

    it "doesn't show the relations module for employees" do
      @user = FactoryGirl.create(:user, :role => 'customer', :company => @company)
      FactoryGirl.create(:user_tms, :user => @user)

      logout_and_login_user(@user)
      visit contacts_url

      page.should have_content(I18n.t :not_allowed)
      page.should have_content(I18n.t :contacts_index_title)
    end
  end      

  describe "NEW add a new contact" do
    it "can add a new contact" do
      visit new_contact_url
      select(@relation.name, :from => 'contact_relation_id')
      fill_in 'contact_first_name', :with => 'Theo'
      fill_in 'contact_last_name', :with => 'Test'
      click_button I18n.t(:form_save_button)

      page.should have_content(I18n.t :message_contact_created)
      page.should have_content(@relation.name)
      page.should have_content("Theo Test")
    end
  end

  describe "EDIT change an existing contact" do
    it "can edit a existing contact" do
      @contact = FactoryGirl.create(:contact, :relation => @relation) 

      visit edit_contact_url(@contact)

      fill_in 'contact_last_name', :with => 'Changed'
      click_button I18n.t(:form_save_button)

      page.should have_content(I18n.t :message_contact_updated)
      page.should have_content("Changed")
    end
  end

  describe "DELETE remove an existing contact" do
    it "removes an existing contact" do
      visit contact_url(@contact)
      click_link I18n.t :form_delete_button

      page.should have_content(I18n.t :message_contact_deleted)
    end
  end

end
