require 'spec_helper'
require 'capybara'
=begin
describe "on the platform" do

  let(:company) {FactoryGirl.create(:company)}
  let(:subscription) {FactoryGirl.create(:subscription, :company => company)}

  describe "[relations] a user" do

    let(:user) {FactoryGirl.create(:user, :role => 'user', :company => company, :mod_platform => true)}
    let(:relation) {FactoryGirl.create(:relation, :company_contact => user, :company => company)}
    let(:contact) {FactoryGirl.create(:contact, :relation => relation)}

  	before(:each) do
  		visit root_path
  		click_link "Inloggen"
  		fill_in 'email', :with => user.email
      fill_in 'password', :with => user.password
      click_button 'Inloggen'
  	end

  	it "can see relations on the relations overview page" do
  		visit relations_path
  	  page.should have_selector("div", :class => "pagetitle", :content => "Overzicht relaties")
  	end

  	it "can see the relation details" do
  		visit relation_path(relation)
  	  page.should have_selector("div", :class => "title", :content => relation.name)
  	end

  	it "can't see the relations from another company" do
      # Other company
      company_b = FactoryGirl.create(:company)
      subscription_b = FactoryGirl.create(:subscription, :company => company_b)
      user_b = FactoryGirl.create(:user, :role => 'user', :last_name => 'Company B', :company => company_b)
      relation_b = FactoryGirl.create(:relation, :name => "Relatie B", :company_contact => user_b, :company => company_b)
      contact_b = FactoryGirl.create(:contact, :first_name => "Bert", :last_name => "Company B", :relation => relation_b)

  		visit relations_path
  	  page.should_not have_content(relation_b.name)
  	end

  	it "can see a search functionality in the overview" do
      visit relations_path
  	 	page.should have_selector("input", :id => "search")
  	end

  	it "can see an export to excel link in the overview" do
      visit relations_path
  	 	page.should have_selector("a", :text => "Exporteren naar excel")
  	end

  	it "can see relation number column in the overview" do
      visit relations_path
  	 	page.should have_selector("th", :class => "header", :text => "Nr.")
  	end

  	it "can see group number column in the overview" do
      visit relations_path
  	 	page.should have_selector("th", :class => "header", :text => "Groep")
  	end

  	it "can edit a relation" do
  	  visit edit_relation_path(relation)
  	 	page.should have_selector("h3", :content => "Wijzigen relatie")
  	end

  	it "can see a relation number when editing" do
  	  visit edit_relation_path(relation)
  	 	page.should have_selector("input", :id => "relation_relation_nr", :disabled => true)
  	end

  	it "can't see delete links in the relations overview" do
  	  visit relations_path
  	 	page.should_not have_selector("a", :text => "verwijderen")
  	end
  end
 
  describe "[relations] a customer" do

    let(:user) {FactoryGirl.create(:user, :role => 'customer', :company => company, :mod_platform => false)}
    let(:relation) {FactoryGirl.create(:relation, :company_contact => user, :company => company)}

  	before(:each) do
  		visit root_path
  		click_link "Inloggen"
  		fill_in 'email', :with => user.email
      fill_in 'password', :with => user.password
      click_button 'Inloggen'
  	end

  	it "can't see the relations link" do
  	 	page.should_not have_content("Relaties")
  	end

  	it "can't deeplink a relation" do
  		visit relations_path
  	  page.should have_selector("p", :class => "alert", :content => "U heeft niet voldoende rechten voor deze aktiviteit")
  	end
  end

  describe "[contacts] a user" do

    let(:user) {FactoryGirl.create(:user, :role => 'user', :company => company, :mod_platform => true)}
    let(:relation) {FactoryGirl.create(:relation, :company_contact => user, :company => company)}
    let(:contact) {FactoryGirl.create(:contact, :relation => relation)}

  	before(:each) do
  		visit root_path
  		click_link "Inloggen"
  		fill_in 'email', :with => user.email
      fill_in 'password', :with => user.password
      click_button 'Inloggen'
  	end

  	it "can see contacts on the relation details page" do
  		visit relation_path(relation)
  	  page.should have_selector("li", :class => "name", :content => "Contact, Cees")
  	end

  	it "can see contacts on the contacts overview page" do
  		visit contacts_path
  	  page.should have_selector("li", :class => "name", :content => contact.last_name + ", " + contact.first_name)
  	end

  	it "can see the contact details" do
  		visit contact_path(contact)
  	  page.should have_selector("li", :class => "title", :content => contact.first_name + " " + contact.last_name)
  	end

  	it "can't see the contacts from another company" do
      # Other company
      company_b = FactoryGirl.create(:company)
      subscription_b = FactoryGirl.create(:subscription, :company => company_b)
      user_b = FactoryGirl.create(:user, :role => 'user', :last_name => 'Company B', :company => company_b)
      relation_b = FactoryGirl.create(:relation, :name => "Relatie B", :company_contact => user_b, :company => company_b)
      contact_b = FactoryGirl.create(:contact, :first_name => "Bert", :last_name => "Company B", :relation => relation_b)

  		visit contacts_path
  	  page.should_not have_content(contact_b.last_name + ", " + contact_b.first_name)
  	end
  end
  
  describe "[tasks] a user" do

    let(:user) {FactoryGirl.create(:user, :role => 'user', :company => company, :mod_platform => true)}
    let(:relation) {FactoryGirl.create(:relation, :company_contact => user, :company => company)}
    let(:contact) {FactoryGirl.create(:contact, :relation => relation)}
    let(:task) {FactoryGirl.create(:task, :user => user, :contact => contact)}

  	before(:each) do
  		visit root_path
  		click_link "Inloggen"
  		fill_in 'email', :with => user.email
      fill_in 'password', :with => user.password
      click_button 'Inloggen'
    end
    
  	it "can see tasks on the tasks overview page" do
  		visit tasks_path
  	  page.should have_selector("div", :class => "pagetitle", :content => "Overzicht taken")
  	end

  	it "can see the tasks of a contact" do
  		visit contact_path(contact)
  	  page.should have_content("Taken")
  	  page.should have_selector("div", :class => "taskdetails", :content => task.task)
  	end

  	it "can add an task to a contact" do
  		visit contact_path(contact)
  		click_link "Taken"
  	  page.should have_selector("input", :id => "task_task")
  	end

  	it "can't see the tasks of a contact from another company" do
      # Other company
      company_b = FactoryGirl.create(:company)
      subscription_b = FactoryGirl.create(:subscription, :company => company_b)
      user_b = FactoryGirl.create(:user, :role => 'user', :last_name => 'Company B', :company => company_b)
      relation_b = FactoryGirl.create(:relation, :name => "Relatie B", :company_contact => user_b, :company => company_b)
      contact_b = FactoryGirl.create(:contact, :first_name => "Bert", :last_name => "Company B", :relation => relation_b)
      task_b = FactoryGirl.create(:task, :task => "Taak B", :user => user_b, :contact => contact_b)

  		visit tasks_path
  	  page.should_not have_content(task_b.task)
  	end
  end

  describe "[notes] a user" do
    let(:user) {FactoryGirl.create(:user, :role => 'user', :company => company, :mod_platform => true)}
    let(:relation) {FactoryGirl.create(:relation, :company_contact => user, :company => company)}
    let(:contact) {FactoryGirl.create(:contact, :relation => relation)}
    let(:note) {FactoryGirl.create(:note, :user => user, :contact => contact)}

  	before(:each) do
  		visit root_path
  		click_link "Inloggen"
  		fill_in 'email', :with => user.email
      fill_in 'password', :with => user.password
      click_button 'Inloggen'
    end

  	it "can see notes on the notes overview page" do
  		visit notes_path
  	  page.should have_selector("div", :class => "pagetitle", :content => "Overzicht notities")
  	end
  	
  	it "can see the notes of a contact" do
  		visit contact_path(contact)
  		click_link "Notities"

  	  page.should have_content("Notities")
  	  page.should have_selector("div", :class => "notedetails", :content => note.subject)
  	end

  	it "can add a note to a contact" do
  		visit contact_path(contact)
  		click_link "Notities"

  	  page.should have_selector("input", :id => "note_subject")
  	end

  	it "can't see the tasks of a contact from another company" do
      # Other company
      company_b = FactoryGirl.create(:company)
      subscription_b = FactoryGirl.create(:subscription, :company => company_b)
      user_b = FactoryGirl.create(:user, :role => 'user', :last_name => 'Company B', :company => company_b)
      relation_b = FactoryGirl.create(:relation, :name => "Relatie B", :company_contact => user_b, :company => company_b)
      contact_b = FactoryGirl.create(:contact, :first_name => "Bert", :last_name => "Company B", :relation => relation_b)
      note_b = FactoryGirl.create(:note, :subject => "Note B", :user => user_b, :contact => contact_b)

  		visit notes_path
  	  page.should_not have_content(note_b.subject)
  	end
  end

  describe "[agreements] a user" do
    let(:user) {FactoryGirl.create(:user, :role => 'user', :company => company, :mod_platform => true)}
    let(:relation) {FactoryGirl.create(:relation, :company_contact => user, :company => company)}
    let(:contact) {FactoryGirl.create(:contact, :relation => relation)}
    let(:agreement) {FactoryGirl.create(:agreement, :user => user, :contact => contact)}

  	before(:each) do
  		visit root_path
  		click_link "Inloggen"
  		fill_in 'email', :with => user.email
      fill_in 'password', :with => user.password
      click_button 'Inloggen'
    end

  	it "can see agreements on the notes overview page" do
  		visit agreements_path
  	  page.should have_selector("div", :class => "pagetitle", :content => "Overzicht afspraken")
  	end
  	
  	it "can see the agreements of a contact" do
  		visit contact_path(contact)
  		click_link "Afspraken"

  	  page.should have_content("Afspraken")
  	  page.should have_selector("div", :class => "agreementdetails", :content => agreement.agreement)
  	end

  	it "can add an agreement to a contact" do
  		visit contact_path(contact)
  		click_link "Afspraken"

  	  page.should have_selector("input", :id => "agreement_agreement")
  	end

  	it "can't see the agreements of a contact from another company" do
      # Other company
      company_b = FactoryGirl.create(:company)
      subscription_b = FactoryGirl.create(:subscription, :company => company_b)
      user_b = FactoryGirl.create(:user, :role => 'user', :last_name => 'Company B', :company => company_b)
      relation_b = FactoryGirl.create(:relation, :name => "Relatie B", :company_contact => user_b, :company => company_b)
      contact_b = FactoryGirl.create(:contact, :first_name => "Bert", :last_name => "Company B", :relation => relation_b)
      agreement_b = FactoryGirl.create(:agreement, :agreement => "Agreement B", :user => user_b, :contact => contact_b)

  		visit agreements_path
  	  page.should_not have_content(agreement_b.agreement)
  	end
  end 
end
=end