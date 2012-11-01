require 'spec_helper'

describe Tasktype do
  it { should belong_to(:company) }

  it { should validate_presence_of(:tasktype) }
  it { should validate_presence_of(:company_id) }
end
