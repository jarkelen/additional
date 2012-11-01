FactoryGirl.define do
  factory :ins_market do
    market        'test'
    company_id    { FactoryGirl.create(:company) }
  end
end

