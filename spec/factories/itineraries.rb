FactoryBot.define do
  factory :itinerary do
    date               { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)}
    place              { Faker::Lorem.word }
    memo               { Faker::Lorem.word }
    transportation_id  { Faker::Number.within(range: 1..6)}

    association :plan
  end
end
