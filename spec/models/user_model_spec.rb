require 'spec_helper'

describe User do
  def new_user(options={})
    @new_user ||= FactoryGirl.build(:user, options)
  end

  def user(options={})
    @user ||= FactoryGirl.create(:user, options)
  end

  it "saves a new User" do
    new_user.save!
  end

  describe "#first_name" do
    it { should validate_presence_of :first_name }
    it { should ensure_length_of(:first_name).is_at_most(User::FIRST_NAME_MAX_LENGTH) }
  end

  describe "#last_name" do
    it { should validate_presence_of :last_name }
    it { should ensure_length_of(:last_name).is_at_most(User::LAST_NAME_MAX_LENGTH) }
  end

  describe "#role" do
    it { should validate_presence_of :role }
  end

  describe "#email" do
    it { should validate_presence_of :email }
    it { should ensure_length_of(:email).is_at_most(User::EMAIL_MAX_LENGTH) }
    %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp].each do |email|
      it { should validate_format_of(:email).with(email) }
    end

    %w[user@foo,com user_at_foo.org example.user@foo.].each do |email|
      it { should_not validate_format_of(:email).with(email) }
    end

    ##it { should validate_uniqueness_of(:email) }

    it "should reject duplicate email addresses" do
      user({ email: 'test@test.nl' })
      new_user({ email: 'test@test.nl' })
      new_user.should_not be_valid
      new_user.should have(1).error_on(:email)
    end
    
=begin
    it "should reject email addresses identical up to case" do
      upcased_email = 'TEST@TEST.nl'
      FactoryGirl.create(:user, email: upcased_email)
      FactoryGirl.build(:user, email: upcased_email).should_not be_valid
    end
=end
  end

  describe "#company" do
    it { should validate_presence_of :company }
  end

  
end
