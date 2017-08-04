FactoryGirl.define do
  factory :order_item do
    association :order
    association :product

    unit_price { 12 }
    quantity { 6 }
    total_price { unit_price * quantity }

    # trail :quantity do
    #   quantity 0
    # end
  end
end
