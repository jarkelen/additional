FactoryGirl.define do
  factory :contact do
    first_name          'Cees'
    last_name           'Contact'
    email               'test@test.nl'
    function            'consultant'
    telephone_business  '32478347384734'
    telephone_private   '32478347384734'
    telephone_mobile    '32478347384734'
    twitter             'djdfhdjfh'
    facebook            'djdfhdjfh'
    linkedin            'djdfhdjfh'
    background          'sjsjhdsjdbsdsbd jsdsdbjs'
    salutation          'Dhr.'
    gender              'Male'
    title               'Mr.'
    fax                 '364834837483'
    birth_date          30.years.ago
    custom_label_1      'Test'
    custom_field_1      'Test'
    custom_label_2      'Test'
    custom_field_2      'Test'
    custom_label_3      'Test'
    custom_field_3      'Test'
    has_boss            1
    relation_id        { FactoryGirl.create(:relation) }
  end
end

