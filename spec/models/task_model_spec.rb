require 'spec_helper'

describe Task do
  it { should belong_to(:contact) }
  it { should belong_to(:user) }
  it { should belong_to(:dossier) }

  it { should validate_presence_of(:task_type) }
  it { should validate_presence_of(:task) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:due_at) }
  it { should validate_presence_of(:contact_id) }
end