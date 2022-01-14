FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    introduction { Faker::Lorem.characters(number: 100) }
    email { Faker:Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end