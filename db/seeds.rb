# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Product.destroy_all
Category.destroy_all
20.times do
    User.create(first: Faker::Name.first_name, last:Faker::Name.last_name, email: Faker::Internet.username+"@gmail.com", username: Faker::Internet.username, password: Faker::Internet.password) #password: Faker::Internet.password
end
Category.create(name: "Books", description:Faker::Lorem.paragraphs(number: 1))
Category.create(name: "Shoes", description:Faker::Lorem.paragraphs(number: 1))
Category.create(name: "Clothing", description:Faker::Lorem.paragraphs(number: 1))
Category.create(name: "Home", description:Faker::Lorem.paragraphs(number: 1))
Category.create(name: "Electronics", description:Faker::Lorem.paragraphs(number: 1))
Category.create(name: "Jewelry", description:Faker::Lorem.paragraphs(number: 1))
Category.create(name: "Sporting Goods", description:Faker::Lorem.paragraphs(number: 1))
Category.create(name: "Art and Crafts", description:Faker::Lorem.paragraphs(number: 1))
20.times do
    Product.create(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraphs(number: 1), price: rand(100), user_id: User.all.ids[rand(0 .. 19)], status: [true, false].sample, quantity: rand(3), category_id: Category.all.ids[rand(0..7)]) 
end

User.create(first: "jane", last:"doe", email:"admin@email.com",username:"adminuser", password: "abcdefghi", admin: 'true')

# img:Faker::LoremFlickr.image(size: "50x60")