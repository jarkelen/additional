require 'spec_helper'
require 'capybara'

describe "relation" do

  before :each do
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company) 
    @user = FactoryGirl.create(:user, 
                               :role => 'company_admin', 
                               :company => @company)
    FactoryGirl.create(:user_tms, :user => @user)
      
    login_user(@user)
  end
  
  describe "INDEX show all relations" do
    before :each do
      @relation_a = FactoryGirl.create(:relation, 
                                       :company => @company, 
                                       :name => "Relation A")
      @relation_b = FactoryGirl.create(:relation, 
                                       :company => @company, 
                                       :name => "Relation B")
      @relation_c = FactoryGirl.create(:relation, 
                                       :company => @company, 
                                       :name => "Relation C")
    end

    it "shows the relations" do
      visit relations_url

      page.should have_content(I18n.t :relations_index_title)
      page.should have_content(@relation_a.name)
      page.should have_content(@relation_b.name)
      page.should have_content(@relation_c.name)
    end

    it "shows the map" do
      page.should have_selector("div", :class => "map_container")
    end

    it "shows the filter fields" do
      page.should have_selector("div", :class => "filter")
    end
  end

  describe "SHOW all relation details" do
    before :each do
      @relation = FactoryGirl.create(:relation, 
                                     :company => @company, 
                                     :name => "Relation A")
    end

    it "shows the relation details" do
      visit relation_url(@relation)

      page.should have_selector("a", :content => I18n.t(:relations_all))
      page.should have_selector("a", :content => I18n.t(:form_edit_button))
      page.should have_selector("a", :content => I18n.t(:form_delete_button))
      page.should have_selector("div", :class => "contact")
      page.should have_content(@relation.name)
      page.should have_content(@relation.visit_address)
      page.should have_content(@relation.visit_zipcode)
      page.should have_content(@relation.visit_city)
      page.should have_content(@relation.visit_country)
    end
  end

  describe "NEW add a new relation" do
    it "can add a new relation" do
      @country = FactoryGirl.create(:country) 
      @rel_type = FactoryGirl.create(:rel_type) 

      visit new_relation_url
      fill_in 'relation_name', :with => 'Test BV'
      fill_in 'relation_relationgroup_new', :with => 'TBV'
      fill_in 'relation_bankaccount', :with => '123456'
      fill_in 'relation_kvk_nr', :with => '123456'
      fill_in 'relation_email', :with => 'info@test.nl'
      fill_in 'relation_visit_address', :with => 'Teststraat 1'
      fill_in 'relation_visit_zipcode', :with => '5611 XG'
      fill_in 'relation_visit_city', :with => 'Eindhoven'
      select('Nederland', :from => 'relation_visit_country')
      click_button I18n.t(:form_save_button)

      page.should have_content(I18n.t :message_relation_created)
      page.should have_content("Test BV")
      page.should have_content("TST0001")
    end
  end

  describe "EDIT change an existing relation" do
    it "can edit a existing relation" do
      @country = FactoryGirl.create(:country) 
      @rel_type = FactoryGirl.create(:rel_type) 
      @relation = FactoryGirl.create(:relation, 
                                     :company => @company, 
                                     :name => "Test BV")

      visit edit_relation_url(@relation)

      fill_in 'relation_name', :with => 'Changed BV'
      click_button I18n.t(:form_save_button)

      page.should have_content(I18n.t :message_relation_updated)
      page.should have_content("Changed BV")
    end
  end

  describe "DELETE remove an existing relation" do
    it "can edit a existing relation" do
      @relation = FactoryGirl.create(:relation, 
                                     :company => @company, 
                                     :name => "Test BV")

      visit relation_url(@relation)
      click_link I18n.t :form_delete_button

      page.should have_content(I18n.t :message_relation_deleted)
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
