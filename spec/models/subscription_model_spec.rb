require 'spec_helper'

describe Subscription do
  it { should belong_to(:company) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:billing_period) }
  it { should validate_presence_of(:user_price) }
  it { should validate_presence_of(:active) }

end