FactoryBot.define do
  factory :notification do
    association :visitor
    association :visited
    association :post
    association :comment
    association :favorite
    association :message
    association :room
  end
end