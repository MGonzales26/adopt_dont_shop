FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
    street_address { Faker::Address.street_address }
    city  { Faker::Address.city }
    state { Faker::Address.state }
    zip_code  { Faker::Address.zip_code }
    status { "In Progress" }
  end
end