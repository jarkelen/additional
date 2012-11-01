FactoryGirl.define do
  factory :ins_type do
    ins_type            'Test'
    ins_branch_id       { FactoryGirl.create(:ins_branch) }
    company_id          { FactoryGirl.create(:company) }
  end
end

