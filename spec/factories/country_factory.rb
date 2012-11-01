FactoryGirl.define do
  factory :country do
    country     'Nederland'
    company_id  { FactoryGirl.create(:company) }
  end
end
