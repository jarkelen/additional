require 'spec_helper'

describe Company do
  it { should have_many(:users) }
  it { should have_many(:relations) }
  it { should have_many(:contacts) }
  it { should have_many(:notes) }
  it { should have_many(:tasks) }
  it { should have_many(:agreements) }
  it { should have_many(:ins_insurances) }
  it { should have_many(:ins_branches) }
  it { should have_many(:ins_types) }
  it { should have_many(:ins_markets) }
  it { should have_many(:ins_insurers) }
  it { should have_many(:ins_mediators) }
  it { should have_many(:countries) }
  it { should have_many(:sectors) }
  it { should have_many(:branches) }
  it { should have_many(:tasktypes) }
  it { should have_many(:rel_types) }

  it { should have_one(:subscription) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address1) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:email) }


end