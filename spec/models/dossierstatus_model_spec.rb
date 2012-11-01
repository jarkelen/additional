require 'spec_helper'

describe DossierStatus do
  it { should belong_to(:company) }

  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:company_id) }

end