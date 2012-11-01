require 'spec_helper'

describe AgreementsController do

   before :each do
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company) 
    @user = FactoryGirl.create(:user, 
                               :role => 'company_admin', 
                               :company => @company)
    FactoryGirl.create(:user_tms, :user => @user)
    @relation = FactoryGirl.create(:relation, :company => @company)
    @contact = FactoryGirl.create(:contact, :relation => @relation) 
    FactoryGirl.create(:agreement, :contact => @contact, :user => @user) 
  end

  describe "GET index" do
    it "creates an instance of Agreement" do
      get :index
      it { should respond_with :success }
      it { should render_template :index }
      it { should render_with_layout }
      it { should_not set_the_flash }
    end
  end

end




