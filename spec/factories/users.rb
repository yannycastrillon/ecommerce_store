FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{ n*n }@fakegmail.com" }
    password { 'password123'}

    trait :admin do
      role 'admin'
    end

    trait :customer do
      role 'customer'
    end
  end
end
