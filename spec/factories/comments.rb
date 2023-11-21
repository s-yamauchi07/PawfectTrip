FactoryBot.define do
  factory :comment do
    comment  { Faker::Lorem.characters }
    association :user
    association :plan
  end
end
