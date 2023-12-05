FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Event #{n}" }
    date { Time.zone.now }
    description { "description" }
    # Add other attributes as needed
    association :county
  end
end