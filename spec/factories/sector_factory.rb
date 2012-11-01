FactoryGirl.define do
  factory :sector do
    sector      'Test'
    company_id  { FactoryGirl.create(:company) }
  end
end
