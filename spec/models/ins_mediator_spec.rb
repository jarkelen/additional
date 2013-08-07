require 'spec_helper'

describe InsMediator do
  it { should belong_to(:company) }

  it { should validate_presence_of(:mediator) }
  it { should validate_presence_of(:company_id) }

end