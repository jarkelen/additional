require 'spec_helper'

describe InsInsurer do
  it { should belong_to(:company) }

  it { should validate_presence_of(:insurer) }
  it { should validate_presence_of(:company_id) }

end