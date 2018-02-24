FactoryBot.define do
  factory :deposit do
    notes Faker::Zelda.item
    amount Faker::Number.between(10, 400)
    account
  end
end
