# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Activity.destroy_all
Like.destroy_all


User.create(first_name: "John", last_name: "Depp", email: "JohnDepp@gmail.com", password: "1234")
User.create(first_name: "Batty", last_name: "Rose", email: "BattyRose@gmail.com", password: "1234")
rand(2..5).times do
   User.create(
     first_name: Faker::Name.first_name,
     last_name: Faker::Name.last_name,
     email: Faker::Internet.email,
     password: "1234"

   )
 end
   users = User.all


      Activity.create(name: "Swimming Pool", schedule: "Thursdays", url_img: "https://assets.better.org.uk/uploads/asset/attachment/24470/images_w750h330_Facility_Image_POOL_-_Morden_Park_Pools.jpg")
      Activity.create(name: "spin class", schedule: "Sundays", url_img: "https://media1.popsugar-assets.com/files/thumbor/x-iYhBm_Ni_5pgzJNKe248gWHEw/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2017/12/19/052/n/43387531/tmp_zYA1Dj_ea2448afc38ccfd7_martin-barak-353522.jpg")
      Activity.create(name: "cardio", schedule: "Thursdays", url_img: "https://www.worldgym.com/root/clientImages/WGY9999/WHYWORLDGYM11.jpg?1501583975455")
      Activity.create(name: "yoga", schedule: "Saturdays", url_img: "https://greatist.com/sites/default/files/YogaLingo.jpg")



      activity = Activity.all

       Like.create(user_id: users[0].id, activity_id: activity[0].id)
       Like.create(user_id: users[1].id, activity_id: activity[1].id)

       like = Like.all

  puts Cowsay.say("Created #{users.count} users", :tux)
   puts Cowsay.say("Created #{activity.count} activity", :tux)
   puts Cowsay.say("Created #{like.count} like", :turtle)
