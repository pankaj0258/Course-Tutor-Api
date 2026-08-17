FactoryBot.define do
  factory :tutor do
    sequence(:name) { |n| "Tutor #{n}" }
    sequence(:email) { |n| "tutor#{n}@example.com" }
    experience_years { 5 }
    association :course
  end
end
