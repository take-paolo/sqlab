FactoryBot.define do
  factory :chapter do
    work
    sequence(:name) { |n| "chapter_name#{n}" }
    sequence(:order_number) { |n| n }
  end
end
