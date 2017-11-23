# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Rake::Task["master_data:import"].invoke

puts "Create admin account"
User.new(email: "admin@gmail.com", username: "admin", password: "123456", 
  role: :admin, confirmed_at: Time.zone.now).save validate: false

puts "Create doctor users"
5.times do |i|
  User.create! email: "doctor#{i+1}@gmail.com",
    username: "doctor#{i+1}",
    password: "123456",
    password_confirmation: "123456",
    role: :doctor,
    confirmed_at: Time.zone.now
end

districts = District.all.includes :province
puts "Create clinic"
5.times do |i|
  name = Faker::Company.name
  Clinic.create! name: name,
    phone_number: Faker::PhoneNumber.cell_phone,
    district: districts.sample,
    address: Faker::Address.street_address,
    website: Faker::Internet.url,
    facebook: "https:://facebook.com/#{name.tableize}"
end

clinics = Clinic.all
puts "Create doctor profile"
User.doctor.each_with_index do |user, index|
  DoctorProfile.create! first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    dob: Faker::Date.backward(365 * 50),
    gender: DoctorProfile::genders.values.sample,
    phone_number: Faker::PhoneNumber.cell_phone,
    user: user,
    clinic: clinics[index]
end
