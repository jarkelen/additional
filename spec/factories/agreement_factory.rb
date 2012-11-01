FactoryGirl.define do
  factory :agreement do
    agreement      'Test'
    user           { FactoryGirl.create(:user) }
    contact        { FactoryGirl.create(:contact) }
  end
end
