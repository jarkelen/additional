require 'spec_helper'

describe Dossier do
  it { should belong_to(:company) }

  it { should have_many(:notes) }
  it { should have_many(:tasks) }
  it { should have_many(:agreements) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:user_id) }

  describe ".dropdown_list" do
    it "includes all dossiers" do
      company = FactoryGirl.create(:company)
      user = FactoryGirl.create(:user, :company => company)
      dossier = FactoryGirl.create(:dossier, :company => company)

      Dossier.dropdown_list(user).should include([dossier.title, dossier.id])
    end

    it "doesn't include dossiers from other company" do
      company_a = FactoryGirl.create(:company)
      user_a = FactoryGirl.create(:user, :company => company_a)
      dossier_a = FactoryGirl.create(:dossier, :company => company_a)

      company_b = FactoryGirl.create(:company)
      user_b = FactoryGirl.create(:user, :company => company_b)
      dossier_b = FactoryGirl.create(:dossier, :company => company_b)

      Dossier.dropdown_list(user_a).should_not include([dossier_b.title, dossier_b.id])
    end
  end

end