FactoryBot.define do
  factory :post_hashtag do
    association :post
    association :hashtag
  end
end