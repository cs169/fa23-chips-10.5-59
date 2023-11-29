FactoryBot.define do
  factory :state do
    name { 'Example State' }
    symbol { 'example_state' }
    fips_code { 123 }
    is_territory { false }
    lat_min { 0.0 }
    lat_max { 10.0 }
    long_min { 0.0 }
    long_max { 10.0 }
  end
end