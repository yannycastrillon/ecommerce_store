FactoryGirl.define do
  factory :order do
    association :user
    email { 'andres117@gmail.com' }
    bill_firstname { 'Andres' }
    bill_lastname { 'Puerta' }
    bill_address1 { '7065 Hollywood ave' }
    bill_address2 { 'apt 205' }
    bill_city { 'Los Angeles' }
    bill_state { 'California' }
    bill_zipcode { 90035 }
    phone { 3235675665 }
  end

  trait :pending do
    status 'pending'
  end

  trait :cancelled do
    status 'cancelled'
  end

  trait :total do
    total 0
  end

  factory :invalid_order do
    email nil
  end

end
