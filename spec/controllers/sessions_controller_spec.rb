require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    before :each do
      @valid_attributes = { email: "valid_email", password: "valid_password" }

      User.stub(:find_by_email).and_return(user)
    end

    let(:user) { mock_model(User).as_null_object }

    context "user exists in the system" do
      before :each do
        User.stub(:find_by_email).and_return(user)
      end

      it "creates an instance of User" do
        User.should_receive(:find_by_email).and_return(user)
        post :create, @valid_attributes
      end

      context "user authenticated" do
        before :each do
          user.stub(:authenticate).and_return(true)
          user.stub(:employed?).and_return(true)
        end

        it "resets session"

        it "calls authenticate on user" do
          user.should_receive(:authenticate)
          post :create, @valid_attributes
        end

        it "checks if user is employed" do
          user.should_receive(:employed?)
          post :create, @valid_attributes
        end

        it "sets session to user_id" do
          post :create, @valid_attributes
          session[:user_id].should_not be_nil
        end

        it "updates the user's login stats" do
          user.should_receive(:update_sign_in_stats)
          post :create, @valid_attributes
        end

        it "redirects to dashbboard" do
          post :create, @valid_attributes
          response.should redirect_to(users_dashboard_url)
        end
      end

      context "user unauthenticated" do
        before :each do
          user.stub(:authenticate).and_return(false)
          user.stub(:employed?).and_return(false)
        end

        it "renders tempalte :new" do
          post :create, @valid_attributes
          response.should render_template(:new)
        end
      end
    end

    context "user does not exist in the system" do
      before :each do
        User.stub(:find_by_email).and_return(nil)
      end

      it "renders tempalte :new" do
        post :create ##, @valid_attributes
        response.should render_template(:new)
      end
    end
  end
end
