FactoryGirl.define do
  factory :dossier do
    title         'test'
    status        'test'
    budget        '1000'
    fte           5.0
    user_id            { FactoryGirl.create(:user) }
    company_id         { FactoryGirl.create(:company) }
  end
end
