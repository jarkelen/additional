FactoryGirl.define do
  factory :activity do
    activity        'nieuwe activiteit'
    user_id            { FactoryGirl.create(:user) }
    company_id         { FactoryGirl.create(:company) }
  end
end
