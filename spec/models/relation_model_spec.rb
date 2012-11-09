require 'spec_helper'

describe Relation do
  it { should belong_to(:company) }
  it { should have_many(:contacts) }
  it { should have_many(:tasks) }
  it { should have_many(:notes) }
  it { should have_many(:agreements) }
  it { should have_many(:contacts) }
  it { should have_many(:ins_insurances) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:relation_nr) }
  it { should validate_presence_of(:relation_type) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:company_contact) }
  it { should validate_presence_of(:visit_address) }
  it { should validate_presence_of(:visit_zipcode) }
  it { should validate_presence_of(:visit_city) }
  it { should validate_presence_of(:visit_country) }
  it { should validate_presence_of(:company_id) }

  before :each do
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company) 
  end

  describe "uniqueness validations" do
    before :each do
      FactoryGirl.create(:relation, :company => @company)
      FactoryGirl.create(:relation, :company => @company)
    end

    it { should validate_uniqueness_of(:relation_nr) }
    it { should validate_uniqueness_of(:kvk_nr) }
  end

  it "accepts valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      FactoryGirl.build(:relation, email: address).should be_valid
    end
  end

  #------------------------------- CLASS METHODS -------------------------------

  describe ".search" do
    before :each do
      @relation = FactoryGirl.create(:relation, 
                                       :company => @company, 
                                       :name => "Test Inc.")
    end

    it "should return Test Inc." do
      Relation.search("Test").should have(1).record
    end

    it "shouldn't return a not existing relation" do
      Relation.search("bla").should have(0).records
    end
  end

  describe ".filter" do
    before :each do
      @relation = FactoryGirl.create(:relation, 
                                       :company => @company, 
                                       :name => "Test Inc.")
    end

    pending "should return Test Inc." do
      Relation.filter({ :name => @relation.name }).should have(1).record
    end

    it "shouldn't return a not existing relation" do
      Relation.filter({ :name => 'bla' }).should have(0).records
    end
  end

  describe ".get_company_code" do
    it "should return the current user's company code" do
      @user = FactoryGirl.create(:user, :role => 'user', :company => @company)
      Relation.get_company_code(@user).should == "#{@company.code}"
    end
  end

  describe ".get_new_relation_nr" do
    it "should return the new relation nr" do
      @user = FactoryGirl.create(:user, :role => 'user', :company => @company)
      Relation.get_new_relation_nr(@user).should == "0001"
    end
  end

  describe ".add_leading_zeros" do
    it "should return a single number with three added zeros" do
      Relation.add_leading_zeros("2").should == "0002"
    end

    it "should return a double number with two added zeros" do
      Relation.add_leading_zeros("22").should == "0022"
    end
  end

  #------------------------------- INSTANCE METHODS -------------------------------

  describe "#set_new_relationgroup" do
    it "should store a new relationgroup as relationgroup" do
      relation = FactoryGirl.create(:relation, :company => @company,
                                    :relationgroup => '',
                                    :relationgroup_new => 'TIT')
      relation.send(:set_new_relationgroup).should == 'TIT'
    end
  end

end