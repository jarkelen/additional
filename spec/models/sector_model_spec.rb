require 'spec_helper'

describe Sector do
  it { should belong_to(:company) }

  it { should have_many(:branches) }

  it { should validate_presence_of(:sector) }
  it { should validate_presence_of(:company_id) }

end