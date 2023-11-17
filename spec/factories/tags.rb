FactoryBot.define do
  factory :tag do
    tag_name { Faker::Lorem.words(number: 1) }
  end
end
