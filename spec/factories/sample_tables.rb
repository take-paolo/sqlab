FactoryBot.define do
  factory :sample_table do
    practice
    sequence(:uid) { |n| n }
  end
end
