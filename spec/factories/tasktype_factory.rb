FactoryGirl.define do
  factory :tasktype do
    tasktype      'Test'
    company_id  { FactoryGirl.create(:company) }
  end
end
