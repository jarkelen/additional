FactoryGirl.define do
  factory :ins_insurer do
    market        'test'
    company_id    { FactoryGirl.create(:company) }
  end
end

