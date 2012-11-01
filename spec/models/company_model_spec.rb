require 'spec_helper'

describe Company do
  it { should have_many(:users) }
  it { should have_many(:relations) }
  it { should have_many(:contacts) }
  it { should have_many(:notes) }
  it { should have_many(:tasks) }
  it { should have_many(:agreements) }
  it { should have_many(:dossiers) }
  it { should have_many(:alerts) }
  it { should have_many(:mpl_marketplaces) }
  it { should have_many(:mpl_offers) }
  it { should have_many(:mpl_bids) }
  it { should have_many(:inv_invoices) }
  it { should have_many(:inv_categories) }
  it { should have_many(:inv_statuses) }
  it { should have_many(:inv_paymentconditions) }
  it { should have_many(:inv_taxes) }
  it { should have_many(:ins_insurances) }
  it { should have_many(:ins_branches) }
  it { should have_many(:ins_types) }
  it { should have_many(:ins_markets) }
  it { should have_many(:tms_timesheets) }
  it { should have_many(:tms_unbillables) }
  it { should have_many(:tms_publicholidays) }
  it { should have_many(:tms_departments) }
  it { should have_many(:dec_declarations) }
  it { should have_many(:dec_categories) }
  it { should have_many(:mob_cars) }
  it { should have_many(:tms_projects) }

  it { should have_one(:subscription) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address1) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:email) }


end