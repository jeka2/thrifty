# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

1.upto(5) do |i|
    Department.create(name: "Department #{i}", description: Faker::Lorem.sentence(word_count: 100))
end

1.upto(10) do |i| 
    u = User.create(email:"a#{i}@a.com", password: 'Password1!', role:'admin')
    5.times do
        u.items.create(name: Faker::House.furniture, price: (rand(1.0..10.0) * 10).round(2), quantity: rand(1..10), description: Faker::Lorem.sentence(word_count: 50), department: Department.all.sample)
    end
end

1.upto(40) do |i|
    c = Comment.create(content: Faker::Lorem.sentence(word_count: 10), user_id: User.all.sample.id, item_id: 1)
end


[*2..40].each do |num|
    Comment.find(rand(1..num-1)).children << Comment.find(num)
end