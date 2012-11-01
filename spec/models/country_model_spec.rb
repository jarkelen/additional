require 'spec_helper'

describe Country do
  it { should belong_to(:company) }

  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:company_id) }
end