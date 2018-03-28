User.destroy_all
Account.destroy_all
20.times do
  User.create!(name: Faker::Simpsons.unique.character,
              username: Faker::Pokemon.unique.name,
              email: Faker::Internet.unique.email,
              password: Faker::Internet.password(8))

  user = User.last

  Account.create!(user_id: user.id,
                  balance: rand(0..800))
end

p "Created #{User.count} members!"
p "Created #{Account.count} accounts!"
