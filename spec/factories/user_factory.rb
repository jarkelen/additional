FactoryGirl.define do
  factory :user do
    email           { FactoryGirl.generate :email }
    password        'password1'
    first_name      'theo'
    middle_name     'de'
    last_name       'tester'
    position        'consultant'
    department      'TSZ'
    role            'user'
    locale          'nl'
    mod_platform    true
    mod_marketplace true
    mod_employee    true
    mod_invoice     true
    mod_insurance   true
    mod_timesheet   true
    mod_declaration true
    mod_mobility    true
    company         { FactoryGirl.create(:company) }
  end
end
