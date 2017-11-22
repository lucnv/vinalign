# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Create admin account"
User.new(email: "admin@gmail.com", username: "admin", password: "123456", 
  role: :admin, confirmed_at: Time.zone.now).save validate: false

puts "Create bussiness users"
5.times do |i|
  User.create! email: "doctor#{i+1}@gmail.com",
    username: "doctor#{i+1}",
    password: "123456",
    password_confirmation: "123456",
    role: :doctor,
    confirmed_at: Time.zone.now
end
