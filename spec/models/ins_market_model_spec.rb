require 'spec_helper'

describe InsMarket do
  it { should belong_to(:company) }

  it { should validate_presence_of(:market) }
  it { should validate_presence_of(:company_id) }

end