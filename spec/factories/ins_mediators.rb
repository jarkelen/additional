FactoryGirl.define do
  factory :ins_mediator do
    mediator        'test'
    company_id    { FactoryGirl.create(:company) }
  end
end

