FactoryGirl.define do
  factory :company do
    name            'test company'
    address1        'teststreet 1'
    zipcode         '5647 JB'
    city            'testcity'
    country         'Nederland'
    email           {"info_#{rand(1000).to_s}#{rand(1000).to_s}#{rand(1000).to_s}#{rand(1000).to_s}#{rand(1000).to_s}@company.nl" }
    code            'TST'
  end
end
