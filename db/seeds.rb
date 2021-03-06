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
    200.times do
        u.items.create(name: Faker::House.furniture, price: (rand(1.0..10.0) * 10).round(2), quantity: rand(1..10), description: Faker::Lorem.sentence(word_count: 50), department: Department.all.sample)
    end
end

categories = ['kids','auto','music','video games','hobby','movies','toys','guns','food']
categories.each do |name|
    Category.create(name: name, description: Faker::Lorem.sentence(word_count: 50))
end

Item.all.each do |item|
    item.category_ids = Category.all.sample(3).map(&:id)
end