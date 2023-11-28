FactoryBot.define do
  factory :plan do
    title            { Faker::Lorem.word }
    departure_date   { Faker::Date.between(from: Date.today, to: 1.year.from_now).strftime("%Y-%m-%d")}
    return_date      { Faker::Date.between(from: Date.today, to: 1.year.from_now).strftime("%Y-%m-%d")}
    departure_id     { Faker::Number.within(range: 2..48)}
    destination_id   { Faker::Number.within(range: 2..48)}
    companion_id     { Faker::Number.within(range: 2..6)}
    tag              { Faker::Lorem.words }

    association :pet
    association :user

    after(:build) do |plan|
      plan.cover_image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
