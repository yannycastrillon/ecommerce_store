FactoryGirl.define do
  factory :order_item do
    association :order
    association :product

    unit_price { 12 }
    quantity { 6 }
    total_price { 15 }


  end
end
