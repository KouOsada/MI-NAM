FactoryBot.define do
  factory :hashtag do
    name { Faker::Lorem.characters(number: 5) }
  end
end