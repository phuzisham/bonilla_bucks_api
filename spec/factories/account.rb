FactoryBot.define do
  factory :account do
    balance Faker::Number.between(20, 500)
    user
  end
end
