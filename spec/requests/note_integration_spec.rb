require 'spec_helper'
require 'capybara'

describe "note" do

  before :each do
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company) 
    @user = FactoryGirl.create(:user, 
                               :role => 'company_admin', 
                               :company => @company)
    FactoryGirl.create(:user_tms, :user => @user)
    @relation = FactoryGirl.create(:relation, :company => @company)
    @contact = FactoryGirl.create(:contact, :relation => @relation) 
      
    login_user(@user)
  end
  
  describe "INDEX show all notes" do

    it "shows the title" do
      visit notes_url
      page.should have_content(I18n.t :notes_index_title)
    end

    it "shows the notes" do
      @note_a = FactoryGirl.create(:note, 
                                   :subject => "Note A", 
                                   :user => @user, 
                                   :contact => @contact) 
      @note_b = FactoryGirl.create(:note, 
                                   :subject => "Note B", 
                                   :user => @user, 
                                   :contact => @contact) 

      visit notes_url
      page.should have_content(@note_a.subject)
      page.should have_content(@note_a.user.full_name)
      page.should have_content(@note_b.subject)
      page.should have_content(@note_b.user.full_name)
    end
  end

end
