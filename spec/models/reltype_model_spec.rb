require 'spec_helper'

describe RelType do
  it { should belong_to(:company) }

  it { should validate_presence_of(:rel_type) }

end