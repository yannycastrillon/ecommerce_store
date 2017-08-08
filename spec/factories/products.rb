FactoryGirl.define do
  factory :product do
    name { 'Soccer Ball' }
    price { 0 }


    trait :active do
      active true
    end

    trait :invent do
      inventory 12
    end

    factory :invalid_product do
      name nil
      price nil
    end
  end
end
