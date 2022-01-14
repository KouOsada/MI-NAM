FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 400) }
    post_image_id { Faker::Lorem.characters(number: 10) }
    association :user
  end
end