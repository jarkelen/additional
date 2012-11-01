FactoryGirl.define do
  factory :subscription do
    name            'basic'
    discount        0
    start_date      Time.now
    billing_period  'month'
    user_price      10.0
    active          true
    mod_timesheet   true
    mod_employee    true
    mod_mobility    true
    company_id      { FactoryGirl.create(:company) }
  end
end

