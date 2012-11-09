FactoryGirl.define do
  factory :user do
    email           { "test#{rand(10000).to_s}@test.nl" }
    password        'password1'
    first_name      'theo'
    middle_name     'de'
    last_name       'tester'
    position        'consultant'
    department      'TSZ'
    role            'user'
    locale          'nl'
    mod_platform    true
    mod_insurance   true
    company         { FactoryGirl.create(:company) }
  end
end
