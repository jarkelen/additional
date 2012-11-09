FactoryGirl.define do
  factory :note do
    note_type     'Test'
    subject       'Test note'
    note          'Test note'
    attachment    nil
    url           nil
    user_id       { FactoryGirl.create(:user) }
    contact_id    { FactoryGirl.create(:contact) }
  end
end
