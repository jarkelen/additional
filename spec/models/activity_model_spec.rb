require 'spec_helper'

describe Activity do
  it "should create a valid factory" do
    FactoryGirl.create(:activity).should be_valid
  end

  it "should require a activity name" do
    FactoryGirl.build(:activity, activity: nil).should_not be_valid
  end

  it "should require a user id" do
    FactoryGirl.build(:activity, user_id: nil).should_not be_valid
  end

  it "should require a company id" do
    FactoryGirl.build(:activity, company_id: nil).should_not be_valid
  end
  
end