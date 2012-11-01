FactoryGirl.define do
  factory :ins_insurance, :class => InsInsurance do
    insurance_nr                        '123456'
    branch                              'Test'
    insurance_type                      'Test'
    market                              'Test'
    start_date                          Time.now
    duration                            "36"
    first_contract_expiration_date      1.year.from_now
    main_premium_expiration_date        3.year.from_now
    extension                           true
    arrear_calculation                  true
    payment_continuation                '01-01'
    attachment_1                        'test.pdf'
    attachment_2                        'test.pdf'
    attachment_3                        'test.pdf'
    company                             { FactoryGirl.create(:company) }
    relation                            { FactoryGirl.create(:relation) }
  end
end
