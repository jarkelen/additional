require 'spec_helper'

describe Note do
  it { should belong_to(:contact) }
  it { should belong_to(:user) }
  it { should belong_to(:dossier) }

  it { should validate_presence_of(:note_type) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:note) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:contact_id) }

end