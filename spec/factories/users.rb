FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "email#{n}@test.com" }
    role { 0 }
    password { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      role { 10 }
    end
  end
end
