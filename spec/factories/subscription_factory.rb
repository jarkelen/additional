FactoryGirl.define do
  factory :subscription do
    name            'basic'
    discount        0
    start_date      Time.now
    billing_period  'month'
    user_price      10.0
    active          true
    company_id      { FactoryGirl.create(:company) }
  end
end

