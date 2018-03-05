require_relative "seed_tables.rb"

def geocode_address(thing)
  if thing.from_lng && thing.from_lat && thing.from_address.nil?
    geocoded = Geocoder.search([thing.from_lat, thing.from_lng]).first
    if geocoded
      thing.from_address = geocoded.address
    end
  end

  if thing.to_lat && thing.to_lng && thing.to_address.nil?
    geocoded = Geocoder.search([thing.to_lat, thing.to_lng]).first
    if geocoded
      thing.to_address = geocoded.address
    end
  end
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

################################################################################
number_to_requests = 50
number_from_requests = 50

number_to_rides = 40
number_from_rides = 40

#from and to min and max numbers for the map coordinates
bayreuth_min_lat = 49.934095
bayreuth_min_lng = 11.564235

bayreuth_max_lat = 49.949671
bayreuth_max_lng = 11.592198

#Bayreuth uni coordinates
bayreuth_uni_lat = 49.928795
bayreuth_uni_lng = 11.585852

time_frame = 2.days

################################################################################

puts "clearing database"

Offer.destroy_all
Ride.destroy_all
Request.destroy_all
User.destroy_all

puts "cleared"

puts "creating #{user_images.length} users"

user_images.each_with_index do |photo_url, i|
  user = User.new
  user.first_name = user_names(i)
  user.last_name = Faker::Name.last_name
  user.email = "#{user_names(i)}@email.com"
  user.age = rand(20) + 16
  user.remote_photo_url = photo_url
  user.password = "123456"
  user.quote = user_quotes.sample
  genres = user_genres.sample(2)
  user.music = "#{genres[0]},#{genres[1]}"
  user.semester = 1 + rand(9)
  user.course = user_courses.sample
  binding.pry unless user.save
end

################################################################################
#REQUESTS


puts "creating #{number_to_requests} requests to uni"

number_to_requests.times do
  request = Request.new
  request.direction = "to"
  request.start_time = rand(time_frame).seconds.from_now
  request.stop_time = request.start_time + 3.hours + rand(6)*30.minutes
  request.user_id = User.all.sample.id
  request.from_lat = rand_in_range(from_min_lat, from_max_lat)
  request.from_lng = rand_in_range(from_min_lng, from_max_lng)
  request.to_lng = bayreuth_uni_lng
  request.to_lat = bayreuth_uni_lat
  geocode_address(request)
  binding.pry unless request.save
end

puts "creating #{number_to_requests} requests to uni"

number_to_requests.times do
  request = Request.new
  request.direction = "to"
  request.start_time = rand(time_frame).seconds.from_now
  request.stop_time = request.start_time + 3.hours + rand(6)*30.minutes
  request.user_id = User.all.sample.id
  request.from_lat = rand_in_range(from_min_lat, from_max_lat)
  request.from_lng = rand_in_range(from_min_lng, from_max_lng)
  request.to_lng = bayreuth_uni_lng
  request.to_lat = bayreuth_uni_lat
  geocode_address(request)
  binding.pry unless request.save
end

################################################################################


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

################################################################################
#RIDES

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


#ADMINS

puts "Creating admin user"

user = User.new
user.first_name = "Anton"
user.last_name = "Castell"
user.email = "admin@email.com"
user.age = 29
user.remote_photo_url = user_images[2]
user.password = "123456"
user.admin = true
binding.pry unless user.save



