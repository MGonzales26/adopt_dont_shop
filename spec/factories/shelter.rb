FactoryBot.define do
  factory :shelter do
    sequence :name do |n|
      "Shelter #{n}"
    end

    sequence :address do |n|
      "123 fake st ##{n}"
    end

    sequence :city do |n|
      "Denver #{n}"
    end

    sequence :state do |n|
      "Colorado #{n}"
    end

    zip { Faker::Number.number(digits: 5) }
  end
end