require 'spec_helper'

describe Contact do
  it { should belong_to(:relation) }

  it { should have_many(:notes) }
  it { should have_many(:tasks) }
  it { should have_many(:agreements) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:relation_id) }

  before :each do
    @company = FactoryGirl.create(:company)
    subscription = FactoryGirl.create(:subscription, :company => @company) 
    @relation = FactoryGirl.create(:relation, :company => @company)
    @contact_a = FactoryGirl.create(:contact, :relation => @relation, 
                       :first_name => "Piet",
                       :last_name => "Jansen")
    @contact_b = FactoryGirl.create(:contact, :relation => @relation, 
                       :first_name => "Piet", 
                       :middle_name => "de",
                       :last_name => "Vries")
  end

  describe ".search" do
    pending "shows specific contacts when a search is applied" do
      Contact.search({ :search => "Jansen" }).should have(1).record
      Contact.search({ :search => "bla" }).should have(0).records
    end
  end

  describe ".per_letter" do
    pending "shows specific contacts when a letter is applied" do
      Contact.per_letter({ :letter => "V" }).should have(0).records
      Contact.per_letter({ :letter => "A" }).should have(1).record
    end
  end

  describe ".set_alphabet_letters" do
    it "includes all alphabet letters" do
      ("A".."Z").each do |letter|
        Contact.set_alphabet_letters.should include(letter)
      end  
    end

    it "should not include a number" do
      Contact.set_alphabet_letters.should_not include("9")  
    end
  end

  describe ".get_lastname_letters" do
    before :each do
      FactoryGirl.create(:contact, :relation => @relation, :last_name => "Adams")
    end

    it "includes A" do
      contacts = @relation.contacts
      Contact.get_lastname_letters(contacts).should include("A")
    end

    it "doesn't include B" do
      contacts = @relation.contacts
      Contact.get_lastname_letters(contacts).should_not include("B")
    end
  end

  describe ".get_contacts" do
    it "shows contacts for a specific letter" do
      Contact.get_contacts({ :letter => 'J' }).should include(@contact_a)
    end
  end

  describe "#full_name" do
    it "creates a full name with no middle name" do
      @contact_a.full_name.should == "#{@contact_a.first_name} #{@contact_a.last_name}"
    end

    it "creates a full name with a middle name" do
      @contact_b.full_name.should == "#{@contact_b.first_name} #{@contact_b.middle_name} #{@contact_b.last_name}"
    end

  end
 
end