FactoryGirl.define do
  factory :rel_type do
    rel_type    'Test'
    company_id  { FactoryGirl.create(:company) }
  end
end
