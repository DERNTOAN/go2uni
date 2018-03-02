def geocode_address(thing)
  if thing.from_lng && thing.from_lat
    geocoded = Geocoder.search([thing.from_lat, thing.from_lng]).first
    if geocoded
      thing.from_address = geocoded.address
    end
  end

  if thing.to_lat && thing.to_lng
    geocoded = Geocoder.search([thing.to_lat, thing.to_lng]).first
    if geocoded
      thing.to_address = geocoded.address
    end
  end
end
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
number_of_rides = 50


#from and to min and max numbers for the map coordinates
from_min_lat = 49.934095
from_min_lng = 11.564235

from_max_lat = 49.949671
from_max_lng = 11.592198

to_min_lat = 49.925885
to_min_lng = 11.577808

to_max_lat = 49.933534
to_max_lng = 11.589909

demo_from_min_lat = 49.942837
demo_from_min_lng = 11.566964

demo_from_max_lat = 49.936888
demo_from_max_lng = 11.579804

demo_to_min_lat = 49.930340
demo_to_min_lng = 11.581827

demo_to_max_lat = 49.926992
demo_to_max_lng = 11.588384

puts "clearing database"

Offer.destroy_all
Ride.destroy_all
Request.destroy_all
User.destroy_all

puts "cleared"

puts "creating #{number_of_users} users"

number_of_users.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.age = rand(20) + 16
  user.remote_photo_url = Faker::Avatar.image
  user.password = "123456"
  user.description = Faker::Lorem.paragraph
  binding.pry unless user.save
end


puts "creating #{number_of_requests} requests"

50.times do
  request = Request.new
  request.start_time = rand(2.days).seconds.from_now
  request.stop_time = request.start_time + 4.hours + rand(6)*30.minutes
  request.user_id = User.all.sample.id
  request.from_lat = rand_in_range(from_min_lat, from_max_lat)
  request.from_lng = rand_in_range(from_min_lng, from_max_lng)
  request.to_lng = rand_in_range(to_min_lng, to_max_lng)
  request.to_lat = rand_in_range(to_min_lat, to_max_lat)
  geocode_address(request)
  binding.pry unless request.save
end

puts "creating demo requests"

30.times do
  request = Request.new
  request.start_time = (14.hours+rand(3.hours)).seconds.from_now
  request.stop_time = request.start_time + 4.hours + rand(6)*30.minutes
  request.user_id = User.all.sample.id
  request.from_lat = rand_in_range(demo_from_min_lat, demo_from_max_lat)
  request.from_lng = rand_in_range(demo_from_min_lng, demo_from_max_lng)
  request.to_lng = rand_in_range(demo_to_min_lng, demo_to_max_lng)
  request.to_lat = rand_in_range(demo_to_min_lat, demo_to_max_lat)
  geocode_address(request)
  binding.pry unless request.save
end

puts "creating #{number_of_rides} rides with offers equal to number of seats"

50.times do
  ride = Ride.new
  ride.user_id = User.all.sample.id
  ride.seats = 1 + rand(5)
  ride.departure_time = rand(2.days).seconds.from_now
  ride.from_lat = rand_in_range(from_min_lat, from_max_lat)
  ride.from_lng = rand_in_range(from_min_lng, from_max_lng)
  ride.to_lng = rand_in_range(to_min_lng, to_max_lng)
  ride.to_lat = rand_in_range(to_min_lat, to_max_lat)
  geocode_address(ride)
  binding.pry unless ride.save

  ride.seats.times do
    offer = Offer.new
    offer.ride = ride
    request = Request.all.sample
    while request.user == ride.user #to avoid the driver also being a passenger
      request = Request.all.sample
    end
    offer.request_id = request.id
    offer.confirmed = [true, false].sample
    binding.pry unless offer.save
  end
end


puts "Creating Demo Rides"

20.times do
  ride = Ride.new
  ride.user_id = User.all.sample.id
  ride.seats = 1 + rand(5)
  ride.departure_time = rand(2.days).seconds.from_now
  ride.from_lat = rand_in_range(demo_from_min_lat, demo_from_max_lat)
  ride.from_lng = rand_in_range(demo_from_min_lng, demo_from_max_lng)
  ride.to_lng = rand_in_range(demo_to_min_lng, demo_to_max_lng)
  ride.to_lat = rand_in_range(demo_to_min_lat, demo_to_max_lat)
  geocode_address(ride)
  binding.pry unless ride.save

  ride.seats.times do
    offer = Offer.new
    offer.ride = ride
    request = Request.all.sample
    while request.user == ride.user #to avoid the driver also being a passenger
      request = Request.all.sample
    end
    offer.request_id = request.id
    offer.confirmed = [true, false].sample
    binding.pry unless offer.save
  end
end


user = User.new
user.first_name = "Sven"
user.last_name = "Svensson"
user.email = "admin@email.com"
user.age = 99
user.photo = Faker::Avatar.image
user.password = "123456"
binding.pry unless user.save



