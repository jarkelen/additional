require 'spec_helper'
require 'capybara'

describe "insurances" do
  before(:each) do
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company)
    @user = FactoryGirl.create(:user, 
                               :role => 'company_admin', 
                               :company => @company)
    FactoryGirl.create(:user_tms, :user => @user)
    @relation = FactoryGirl.create(:relation, :company => @company)
    
    login_user(@user)
  end

  describe "INDEX" do
    before :each do
      @insurance_a = FactoryGirl.create(:ins_insurance, 
                          :relation => @relation, 
                          :company => @company, 
                          :insurance_nr => "111111")
      @insurance_b = FactoryGirl.create(:ins_insurance, 
                          :relation => @relation, 
                          :company => @company, 
                          :insurance_nr => "999999")
    end

    it "shows all insurances when no filter is applied" do
      visit ins_insurances_url

      page.should have_content(I18n.t :mod_ins_index_title)
      page.should have_content(@insurance_a.insurance_nr)
      page.should have_content(@insurance_b.insurance_nr)
    end

    it "shows the filter fields" do
      page.should have_selector("div", :class => "filter")
    end

    it "shows filtered insurances when a filter is applied" do
      visit ins_insurances_url(:insurance_nr => @insurance_a.insurance_nr, :filter => true)

      page.should have_content(@insurance_a.insurance_nr)
      page.should_not have_content(@insurance_b.insurance_nr)
    end

  end

  pending "SHOW" do
    before :each do
      @insurance = FactoryGirl.create(:ins_insurance, 
                          :relation => @relation, 
                          :company => @company, 
                          :insurance_nr => "111111")
    end

    it "shows the specific insurance details" do
      visit ins_insurance_url(@insurance)

      page.should have_selector("a", :content => I18n.t(:mod_ins_all))
      page.should have_selector("a", :content => I18n.t(:form_edit_button))
      page.should have_selector("a", :content => I18n.t(:form_delete_button))
      page.should have_content(@insurance.insurance_nr)
    end
  end
end
