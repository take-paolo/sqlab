FactoryBot.define do
  factory :work do
    sequence(:name) { |n| "work_name#{n}" }
    sequence(:slug, 'a') { |n| "work_slug#{n}" }
    sequence(:description) { |n| "work_description#{n}" }
    enabled { false }
    published { false }
    sequence(:order_number) { |n| n }

    trait :enabled do
      enabled { true }
    end

    trait :published do
      published { true }
    end

    trait :with_chapters do
      transient do
        chapters_count { 5 }
      end

      after(:create) do |work, evaluator|
        create_list(:chapter, evaluator.chapters_count, work: work)
      end
    end
  end
end
