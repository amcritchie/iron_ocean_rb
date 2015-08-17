# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create Admin User
User.delete_all
admin = User.create(
    email: Figaro.env.admin_email,
    password: Figaro.env.admin_password,
    admin: true,
    image: Rails.root.join("app/assets/images/background_images/iron_dragon.png").open,
    first_name: 'iron',
    last_name: 'ocean',
    address: Figaro.env.admin_address,
    city: Figaro.env.admin_city,
    state: Figaro.env.admin_state,
    zip_code: Figaro.env.admin_zip_code,
    phone_number: Figaro.env.admin_phone_number,
    email_confirmed: true,
    active: true,
    last_active: nil
)

User.create(
    email: Figaro.env.user_email,
    password: Figaro.env.user_password,
    admin: false,
    image: Rails.root.join("app/assets/images/background_images/alex_mcritchie_1.jpg").open,
    first_name: 'Alex',
    last_name: 'McRitchie',
    address: Figaro.env.user_address,
    city: Figaro.env.user_city,
    state: Figaro.env.user_state,
    zip_code: Figaro.env.user_zip_code,
    phone_number: Figaro.env.user_phone_number,
    email_confirmed: false,
    active: true,
    last_active: nil
)

User.create(
    email: 'alexmcray@aol.com',
    password: 'password1',
    admin: false,
    image: Rails.root.join("app/assets/images/background_images/alex_mcritchie_2.jpg").open,
    first_name: 'Alexander',
    last_name: 'McRitchie',
    address: '1234 25th Street',
    city: 'Santa Monica',
    state: 'CA',
    zip_code: '90405',
    phone_number: '1234567890',
    email_confirmed: false,
    active: false,
    last_active: nil
)

Message.delete_all
Message.create(
    sender_id: 1,
    receiver_id: 2,
    unread: false,
    title: "Welcome to Iron Ocean",
    body: "Hello amcritchie@gmail.com, welcome to Iron Ocean."
)

Message.create(
    sender_id: 2,
    receiver_id: 1,
    unread: false,
    title: "Thanks for the welcome",
    body: "Thanks for the welcome, I cant wait to get stared"
)

Message.create(
    sender_id: 1,
    receiver_id: 3,
    unread: false,
    title: "Welcome to Iron Ocean",
    body: "Hello alexmcray@aol.com, welcome to Iron Ocean."
)

Message.create(
    sender_id: 2,
    receiver_id: 3,
    unread: false,
    title: "Hi, how is it going",
    body: "Hi AlexMcRay, how are you?"
)

Message.create(
    sender_id: 3,
    receiver_id: 2,
    unread: false,
    title: "RE Hi, how is it going",
    body: "Im doing very well, how are you?"
)

Message.create(
    sender_id: 2,
    receiver_id: 3,
    unread: false,
    title: "RE RE Hi, how is it going",
    body: "Great, thanks for asking!"
)


Message.create(
    sender_id: 3,
    receiver_id: 2,
    unread: true,
    title: "RE RE RE Hi, how is it going",
    body: "How long have you lived in Denver."
)