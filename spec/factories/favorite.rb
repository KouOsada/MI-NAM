FactoryBot.define do
  factory :favorite do
    association :post
    association :user
  end
end