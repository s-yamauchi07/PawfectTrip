FactoryBot.define do
  factory :hotel_form do
    hotel_num  {Faker::Number.between(from: 1, to: 1000000)}
  end
end
