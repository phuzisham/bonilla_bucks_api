FactoryBot.define do
  factory :user do
    name Faker::GameOfThrones.character
    username Faker::HitchhikersGuideToTheGalaxy.planet
    # email Faker::Internet.email
    password Faker::Internet.password(8)
    sequence :email do |n|
      "person#{n}@example.com"
    end
  end
end
