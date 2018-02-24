FactoryBot.define do
  factory :withdrawl do
    notes Faker::Pokemon.name
    amount Faker::Number.between(5, 200)
    account
  end
end
