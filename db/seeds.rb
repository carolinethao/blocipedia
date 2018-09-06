require 'faker'

25.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::String.random
  )
end
users = User.all

50.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
  )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} topics created"
