FactoryBot.define do
  factory :course do
    sequence(:name) { |n| "Course #{n}" }
    description { "Course description" }
    status { :active }
  end
end
