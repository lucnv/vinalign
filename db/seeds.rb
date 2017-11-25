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

puts "Create user profiles"
User.all.each do |user|
  UserProfile.create! user: user,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    dob: Faker::Date.backward(365 * 50),
    gender: UserProfile::genders.values.sample
end

districts = District.all.includes :province
puts "Create clinic"
User.doctor.each do |user|
  name = Faker::Company.name
  Clinic.create! user: user,
    name: name,
    phone_number: Faker::PhoneNumber.cell_phone,
    district: districts.sample,
    address: Faker::Address.street_address,
    website: Faker::Internet.url,
    facebook: "https:://facebook.com/#{name.tableize}"
end

puts "Create patient records"
Clinic.all.each do |clinic|
  15.times do
    clinic.patient_records.create! start_date: Faker::Date.backward(7),
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      dob: Faker::Date.backward(365 * 50),
      gender: PatientRecord::genders.values.sample,
      district: districts.sample,
      address: Faker::Address.street_address,
      phone_number: Faker::PhoneNumber.cell_phone,
      email: Faker::Internet.email,
      doctor: Faker::Name.name
  end
end

patient_records = PatientRecord.all
puts "Create treatment phases"
patient_records.each do |patient_record|
  phase_count = Faker::Number.between 1, 3
  phase_count.times do |i|
    day_1 = (phase_count - i) * 100
    day_2 = (phase_count - i - 1) * 100
    patient_record.treatment_phases.create! name: "Đợt điều trị #{i+1}",
      start_date: Faker::Date.between(day_1.days.ago, day_2.days.ago),
      description: Faker::Lorem.paragraphs.join("\n")
  end
end

puts "Create price lists"
patient_records.each do |patient_record|
  15.times do 
    patient_record.price_lists.create! item: Faker::Commerce.product_name,
      price: Faker::Commerce.price.to_i * 20_000
  end
end
