require 'spec_helper'

describe Subscription do
  it "should create a valid factory" do
    FactoryGirl.create(:subscription).should be_valid
  end

  it "should require a name" do
    FactoryGirl.build(:subscription, name: nil).should_not be_valid
  end

  it "should require a start date" do
    FactoryGirl.build(:subscription, start_date: nil).should_not be_valid
  end

  it "should require a billing period" do
    FactoryGirl.build(:subscription, billing_period: nil).should_not be_valid
  end

  it "should require a user price" do
    FactoryGirl.build(:subscription, user_price: nil).should_not be_valid
  end

  it "should require a active" do
    FactoryGirl.build(:subscription, active: nil).should_not be_valid
  end

  it "should require a mod timesheet" do
    FactoryGirl.build(:subscription, mod_timesheet: nil).should_not be_valid
  end

  it "should require a mod mobility" do
    FactoryGirl.build(:subscription, mod_mobility: nil).should_not be_valid
  end

  it "should require a mod employee" do
    FactoryGirl.build(:subscription, mod_employee: nil).should_not be_valid
  end

end