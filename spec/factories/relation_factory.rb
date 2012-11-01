FactoryGirl.define do
  factory :relation do
    name                    'Bla Company'
    relation_nr             { "TST#{rand(10000).to_s}" }
    relation_type           'klant'
    status                  'prospect'
    kvk_nr                  { "#{rand(10).to_s}#{rand(10).to_s}#{rand(10).to_s}#{rand(10).to_s}" }
    company_contact         { FactoryGirl.create(:user) }
    visit_address           'Lichstraat 273'
    visit_zipcode           '4567 JN'
    visit_city              'Eindhoven'
    visit_country           'Nederland'
    relationgroup           '123'
    company_id              { FactoryGirl.create(:company) }
  end
end

