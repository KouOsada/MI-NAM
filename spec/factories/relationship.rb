FactoryBot.define do
  factory :relationship do
    association :following
    association :follwer
  end
end