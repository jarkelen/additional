FactoryGirl.define do
  factory :task do
    task_type   'Meeting'
    task        'Test task'
    due_at      1.month.from_now
    user_id     { FactoryGirl.create(:user) }
    contact_id  { FactoryGirl.create(:contact) }
    dossier_id  { FactoryGirl.create(:dossier) }
  end
end
