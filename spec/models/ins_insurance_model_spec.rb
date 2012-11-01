require 'spec_helper'

describe InsInsurance do
  it { should belong_to(:relation) }
  it { should belong_to(:company) }

  it { should validate_presence_of(:insurance_nr) }
  it { should validate_presence_of(:branch) }
  it { should validate_presence_of(:insurance_type) }
  it { should validate_presence_of(:market) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:first_contract_expiration_date) }
  it { should validate_presence_of(:main_premium_expiration_date) }
  it { should validate_presence_of(:extension) }
  it { should validate_presence_of(:payment_continuation) }
  it { should validate_presence_of(:relation_id) }
  it { should validate_presence_of(:company_id) }

  #------------------------------- CLASS METHODS -------------------------------

  before :each do
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company) 
    @relation = FactoryGirl.create(:relation, :company => @company)
    @insurance_a = FactoryGirl.create(:ins_insurance, :relation => @relation, 
                       :insurance_nr => "111111")
    @insurance_b = FactoryGirl.create(:ins_insurance, :relation => @relation, 
                       :insurance_nr => "999999")
  end

  describe ".filter" do
    it "shows specific insurances when a filter is applied" do
      InsInsurance.filter({ :insurance_nr => @insurance_a.insurance_nr }).should have(1).record
    end

    it "shows no insurances when invalid filter is applied" do
      InsInsurance.filter({ :insurance_nr => "555" }).should have(0).records
    end
  end

  describe "#date_for_select" do
    it "shows formatted date for main main_premium_expiration_date" do
      @insurance_a.date_for_select.should == @insurance_a.main_premium_expiration_date.strftime("%d-%m")
    end
  end

end
