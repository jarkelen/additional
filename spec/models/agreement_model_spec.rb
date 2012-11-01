require 'spec_helper'

describe Agreement do
  it { should belong_to(:contact) }
  it { should belong_to(:user) }
  it { should belong_to(:dossier) }

  it { should validate_presence_of(:agreement) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:contact_id) }

  it { should validate_length_of(:agreement).maximum(75) }  
end