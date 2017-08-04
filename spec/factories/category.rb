FactoryGirl.define do
  factory :category do
    name { "New_Category" }
  end

  trait :parent_id do
    parent_id 1
  end

end
