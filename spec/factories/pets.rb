FactoryBot.define do
  factory :pet do
    name        { Faker::Name.first_name }
    breed       { '柴' }
    size_id     { Faker::Number.between(from: 1, to: 4) }
    birthday    { Faker::Date.between(from: 5.days.ago, to: Date.today)}
    association :user
  end
end
