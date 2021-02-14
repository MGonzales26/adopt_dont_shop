FactoryBot.define do
  factory :pet do
    sequence :name do |n|
      "Name #{n}"
    end

    approximate_age { Faker::Number.number(digits: 1) }

    sequence :description do|n|
      "Dog #{n}"
    end

    adoptable { true }
    
    sex { 1 }

    shelter
  end
end