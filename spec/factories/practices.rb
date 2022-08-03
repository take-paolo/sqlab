FactoryBot.define do
  factory :practice do
    chapter
    sequence(:name) { |n| "practice_name#{n}" }
    sequence(:question) { |n| "practice_question#{n}" }
    sequence(:answer) { |n| "practice_answer#{n}" }
    sequence(:sample_database_id) { |n| n }
    display_er_diagram { true }
    enabled { false }
    published { false }
    requires_auth { true }
    sequence(:order_number) { |n| n }

    trait :hidden_er_diagram do
      display_er_diagram { false }
    end

    trait :enabled do
      enabled { true }
    end

    trait :published do
      published { true }
    end

    trait :not_requires_auth do
      requires_auth { false }
    end
  end
end
