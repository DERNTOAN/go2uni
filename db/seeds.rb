# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def rand_in_range(from, to)
  rand * (to - from) + from
end

number_of_users = 30
number_of_requests = 50
number_of_rides = 30


#from and to min and max numbers for the map coordinates
from_min_lat = 49.934095
from_min_lng = 11.564235

from_max_lat = 49.949671
from_max_lng = 11.592198

to_min_lat = 49.925885
to_min_lng = 11.577808

to_max_lat = 49.933534
to_max_lng = 11.589909

puts "clearing database"

Offer.destroy_all
Ride.destroy_all
Request.destroy_all
User.destroy_all

puts "cleared"

avatars = [
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519397727/xykhm11z9u20ayxjfipf.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519397711/ipdiocbobzjf2ggkcqsd.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519397707/qlo2tz4abdvpf8paasgz.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519397685/vs2upa77lyesj21andnc.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519397190/kqe4mjz4zw97qlvpi3bo.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519397155/hzdxjxr2r7fbdvrw14nd.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519396607/kyh9xbouewrmftx5dbyg.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519396582/zxv8einhbswufbibeff3.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519397144/iekweh0br2mwdbempmqc.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519396596/znpiioutlksyfy4rgagv.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519300077/htc2dahghsvxbgohjnb3.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519295885/oojfpfu9mjogkvedvssa.png",
"http://res.cloudinary.com/dlv6654pn/image/upload/v1519217668/mohv0b6fngf6pgoowjnd.png"
]


puts "creating #{number_of_users} users"

number_of_users.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.age = rand(20) + 16
  user.photo = avatars.sample
  user.password = "123456"
  binding.pry unless user.save
end


puts "creating #{number_of_requests} requests"

50.times do
  request = Request.new
  request.start_time = rand(5.days).seconds.from_now
  request.stop_time = request.start_time + 60.minutes + rand(6)*30.minutes
  request.user_id = User.all.sample.id
  request.from_lat = rand_in_range(from_min_lat, from_max_lat)
  request.from_lng = rand_in_range(from_min_lng, from_max_lng)
  request.to_lng = rand_in_range(to_min_lng, to_max_lng)
  request.to_lat = rand_in_range(to_min_lat, to_max_lat)
  binding.pry unless request.save
end

puts "creating #{number_of_rides} rides with offers equal to number of seats"

20.times do
  ride = Ride.new
  ride.user_id = User.all.sample.id
  ride.seats = 1 + rand(5)
  ride.departure_time = rand(5.days).seconds.from_now
  ride.from_lat = rand_in_range(from_min_lat, from_max_lat)
  ride.from_lng = rand_in_range(from_min_lng, from_max_lng)
  ride.to_lng = rand_in_range(to_min_lng, to_max_lng)
  ride.to_lat = rand_in_range(to_min_lat, to_max_lat)
  binding.pry unless ride.save

  ride.seats.times do
    offer = Offer.new
    offer.ride_id = ride.id
    user_id = User.all.sample.id
    while user_id == ride.user.id #to avoid the driver also being a passenger
      user_id = User.all.sample.id
    end
    offer.user_id = user_id
    binding.pry unless offer.save
  end
end


user = User.new
user.first_name = "Sven"
user.last_name = "Svensson"
user.email = "admin@email.com"
user.age = 99
user.photo = avatars.sample
user.password = "123456"
binding.pry unless user.save





