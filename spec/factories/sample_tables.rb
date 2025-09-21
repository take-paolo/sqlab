FactoryBot.define do
  factory :sample_table do
    practice
    sequence(:uid) { SampleTableDefinition.pluck(:id).sample }
  end
end
