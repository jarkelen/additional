=begin
require 'spec_helper'
require 'capybara'

describe "activity" do

	before(:each) do
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company)
    @user = FactoryGirl.create(:user, :role => 'customer', :company => @company, :mod_platform => true)
    FactoryGirl.create(:user_tms, :user => @user)
  end
  
	describe "a customer" do

		before(:each) do
      @activity = FactoryGirl.create(:activity, :user => @user, :company_id => @company)
      login_user(@user)
      save_and_open_page
      
		end

		it "can't see the latest activities" do
		 	page.should_not have_selector("ul", :id => "updates")
		end

		it "can't see activities of it's own company" do
		 	page.should_not have_selector("span", :class => "update", :content => @activity.activity)
		end

		it "can't see activities of another company" do
      company_b = FactoryGirl.create(:company)
      subscription_b = FactoryGirl.create(:subscription, :company => company_b)
      user_b = FactoryGirl.create(:user, :company => company_b)
      activity_b = FactoryGirl.create(:activity, :user => user_b, :company => company_b)
		 	page.should_not have_content(activity_b.activity)
		end
  end
  
end
=end
