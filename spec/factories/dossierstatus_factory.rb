FactoryGirl.define do
  factory :dossier_status do
    status      'Test'
    company_id  { FactoryGirl.create(:company) }
  end
end
