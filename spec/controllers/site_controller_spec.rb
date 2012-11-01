require 'spec_helper'

describe SiteController do

  before :each do
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company)
    @user = FactoryGirl.create(:user, :role => 'user', :company => @company)  
    @company_admin = FactoryGirl.create(:user, :role => 'company_admin', :company => @company)
  end

  describe "GET index" do
    it "creates an instance of User" do
      get :index
      it { should respond_with :success }
      it { should render_template :index }
      it { should render_with_layout }
      it { should_not set_the_flash }
    end
  end

end




