require 'spec_helper'

describe InsType do
  it { should belong_to(:company) }
  it { should belong_to(:ins_branch) }

  it { should validate_presence_of(:ins_type) }
  it { should validate_presence_of(:ins_branch_id) }
  it { should validate_presence_of(:company_id) }

end