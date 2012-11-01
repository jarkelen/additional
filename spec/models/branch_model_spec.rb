require 'spec_helper'

describe Branch do
  it { should belong_to(:company) }
  it { should belong_to(:sector) }

  it { should validate_presence_of(:branch) }
  it { should validate_presence_of(:sector_id) }
  it { should validate_presence_of(:company_id) }
end