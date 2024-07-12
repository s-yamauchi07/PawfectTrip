FactoryBot.define do
  factory :pet do
    name        { Faker::Name.first_name }
    breed       { '柴' }
    size_id     { Faker::Number.between(from: 1, to: 4) }
    association :user
  end
end
