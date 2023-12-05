FactoryBot.define do
  factory :county do
    sequence(:name) { |n| "County #{n}" }
    fips_code { 89 } # Adjust the digits based on your requirements
    # Add other attributes as needed
    association :state
  end
end