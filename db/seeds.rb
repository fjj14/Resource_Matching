# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Product.destroy_all

20.times do
    User.create(first: Faker::Name.first_name, last:Faker::Name.last_name, email: Faker::Internet.username+"@gmail.com", username: Faker::Internet.username, password: Faker::Internet.password) #password: Faker::Internet.password
end
 
20.times do
    Product.create(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraphs(number: 1), price: rand(100), user_id: rand(10000), category_id: rand(10000), status: [true, false].sample, quantity: rand(3)) 
end

# img:Faker::LoremFlickr.image(size: "50x60")