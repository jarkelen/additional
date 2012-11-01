require 'spec_helper'

describe InsBranch do
  it { should belong_to(:company) }
  it { should have_many(:ins_types) }

  it { should validate_presence_of(:branch) }
  it { should validate_presence_of(:company_id) }
end