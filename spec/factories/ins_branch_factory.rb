FactoryGirl.define do
  factory :ins_branch, :class => InsBranch do
    branch                              'Test'
    company                             { FactoryGirl.create(:company) }
  end
end
