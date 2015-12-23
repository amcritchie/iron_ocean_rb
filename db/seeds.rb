# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Reset Database
# $ rake db:drop db:create db:migrate db:seed

# Create Admin User
admin = User.create(
first_name: 'iron', last_name: 'ocean', email: Figaro.env.admin_email,
password: Figaro.env.admin_password, email_confirmed: true, active: true,
last_active: nil, image: Rails.root.join("app/assets/images/seed_images/iron_dragon.png").open
)
admin_address = admin.addresses.create(address: Figaro.env.admin_address, city: Figaro.env.admin_city, state: Figaro.env.admin_state, country: Figaro.env.admin_country, zip: Figaro.env.admin_zip, phone: Figaro.env.admin_phone)
Admin.create(user_id: admin.id, name: 'standard')

alex = User.create(
first_name: 'Alex', last_name: 'McRitchie', email: Figaro.env.user_email,
password: Figaro.env.user_password, email_confirmed: false, active: true,
last_active: nil, image: Rails.root.join("app/assets/images/seed_images/alex_mcritchie_1.jpg").open
)
alex_address = alex.addresses.create(address: Figaro.env.user_address, city: Figaro.env.user_city, state: Figaro.env.user_state, country: Figaro.env.user_country, zip: Figaro.env.user_zip, phone: Figaro.env.user_phone)

patrick = User.create(
first_name: 'Patrick', last_name: 'Bateman', email: 'patrick@pierce.com',
password: 'password1', email_confirmed: false, active: false, last_active: nil,
image: Rails.root.join("app/assets/images/seed_images/patrick_bateman.jpg").open
)
patrick_address = alex.addresses.create(address: '358 exchange place', city: 'yew york', state: 'ny', country: 'usa', zip: Figaro.env.user_zip, phone: '2125556342')


# Message.create( sender_id: 1, receiver_id: 2, title: "Welcome to Iron Ocean",
Message.create( sender_id: admin.id, receiver_id: alex.id, title: "Welcome to Iron Ocean",
body: "Hello amcritchie@gmail.com, welcome to Iron Ocean.", unread: false)

Message.create( sender_id: alex.id, receiver_id: admin.id, title: "Thanks for the welcome",
body: "Thanks for the welcome, I cant wait to get stared.", unread: false)

Message.create( sender_id: admin.id, receiver_id: alex.id, title: "Welcome to Iron Ocean",
body: "Hello alexmcray@aol.com, welcome to Iron Ocean.", unread: false)

Message.create( sender_id: alex.id, receiver_id: patrick.id, title: "Hi, how is it going",
body: "Hi AlexMcRay, how are you?", unread: false)

Message.create(sender_id: patrick.id, receiver_id: alex.id, title: "RE Hi, how is it going",
body: "Im doing very well, how are you?", unread: false)

Message.create( sender_id: alex.id, receiver_id: patrick.id,title: "RE RE Hi, how is it going",
body: "Great, thanks for asking!", unread: false)

Message.create( sender_id: patrick.id, receiver_id: alex.id, title: "RE RE RE Hi, how is it going",
body: "How long have you lived in Denver?", unread: false)

Message.create( sender_id: alex.id, receiver_id: patrick.id, title: "RE RE RE RE Hi, how is it going",
body: "About 3 years now.  How about you?", unread: false)

Message.create( sender_id: patrick.id, receiver_id: alex.id, title: "RE RE RE RE REHi, how is it going",
body: "This is my first winter.", unread: false)
