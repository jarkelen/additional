require 'spec_helper'

describe Activity do
  it { should belong_to(:user) }

  it { should validate_presence_of(:activity) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:company_id) }
end