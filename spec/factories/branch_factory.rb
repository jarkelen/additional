FactoryGirl.define do
  factory :branch do
    branch      'Test'
    sector_id   { FactoryGirl.create(:sector) }
    company_id  { FactoryGirl.create(:company) }
  end
end
