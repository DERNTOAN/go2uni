require_relative "seed_tables"

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
number_to_requests = 60
number_from_requests = 60

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

bayreuth_uni_address = "Universitätsstraße 30, 95447 Bayreuth"

time_frame = 2.days

################################################################################

puts "clearing database"

Offer.destroy_all
Ride.destroy_all
Request.destroy_all
User.destroy_all

puts "cleared"

puts "creating #{USER_IMAGES.length} users"

USER_IMAGES.each_with_index do |photo_url, i|
  user = User.new
  user.first_name = USER_NAMES[i]
  user.last_name = Faker::Name.last_name
  user.email = "#{USER_NAMES[i]}@email.com"
  user.age = rand(20) + 16
  user.remote_photo_url = photo_url
  user.password = "123456"
  user.quote = USER_QUOTES.sample
  genres = USER_GENRES.sample(2)
  user.music = "#{genres[0]}, #{genres[1]}"
  hobbies = USER_HOBBIES.sample(2)
  user.hobby = "#{hobbies[0]}, #{hobbies[1]}"
  user.semester = 1 + rand(9)
  user.course = USER_COURSES.sample
  unless user.save
    print user.errors
    binding.pry
  end
end

################################################################################
#REQUESTS


puts "creating #{number_to_requests} requests to uni"

number_to_requests.times do
  request = Request.new
  request.direction = "to"
  request.start_time = rand(time_frame).seconds.from_now
  request.stop_time = request.start_time + 6.hours + rand(6)*30.minutes
  request.user_id = User.all.sample.id
  request.from_lat = rand_in_range(bayreuth_min_lat, bayreuth_max_lat)
  request.from_lng = rand_in_range(bayreuth_min_lng, bayreuth_max_lng)
  request.to_lng = bayreuth_uni_lng
  request.to_lat = bayreuth_uni_lat
  request.to_address = bayreuth_uni_address
  geocode_address(request)
  unless request.save
    print request.errors
    binding.pry
  end
end

puts "creating #{number_to_requests} requests from uni"

number_to_requests.times do
  request = Request.new
  request.direction = "from"
  request.start_time = rand(time_frame).seconds.from_now
  request.stop_time = request.start_time + 6.hours + rand(6)*30.minutes
  request.user_id = User.all.sample.id
  request.to_lat = rand_in_range(bayreuth_min_lat, bayreuth_max_lat)
  request.to_lng = rand_in_range(bayreuth_min_lng, bayreuth_max_lng)
  request.from_lng = bayreuth_uni_lng
  request.from_lat = bayreuth_uni_lat
  request.from_address = bayreuth_uni_address
  geocode_address(request)
  unless request.save
    print request.errors
    binding.pry
  end
end

################################################################################
#RIDES

puts "creating #{number_to_rides} rides to uni with offers equal to number of seats"

number_to_rides.times do
  ride = Ride.new

  ride.user_id = User.all.sample.id

  #car details
  max_seats = 8
  min_seats = 3
  ride.seats = rand_in_range(min_seats, max_seats)
  ride.car_brand = CAR_BRANDS.sample
  ride.car_color = CAR_COLORS.sample

  #ride date and route
  ride.direction = "to"

  ride.departure_time = rand(time_frame).seconds.from_now

  ride.from_lat = rand_in_range(bayreuth_min_lat, bayreuth_max_lat)
  ride.from_lng = rand_in_range(bayreuth_min_lng, bayreuth_max_lng)

  ride.to_lng = bayreuth_uni_lng
  ride.to_lat = bayreuth_uni_lat
  ride.to_address = bayreuth_uni_address

  geocode_address(ride)

  unless ride.save
    print ride.erros
    binding.pry
  end

  ride.seats.times do
    offer = Offer.new
    offer.ride = ride
    request = Request.where(direction: "to").sample
    while request.user == ride.user #to avoid the driver also being a passenger
      request = Request.all.sample
    end
    offer.request_id = request.id
    offer.confirmed = [true, false].sample
    unless offer.save
      print offer.errors
      binding.pry
    end
  end
end

puts "creating #{number_to_rides} rides from uni with offers equal to number of seats"

number_to_rides.times do
  ride = Ride.new

  ride.user_id = User.all.sample.id

  #car details
  max_seats = 8
  min_seats = 3
  ride.seats = rand_in_range(min_seats, max_seats)
  ride.car_brand = CAR_BRANDS.sample
  ride.car_color = CAR_COLORS.sample

  #ride date and route
  ride.direction = "from"

  ride.departure_time = rand(time_frame).seconds.from_now

  ride.to_lat = rand_in_range(bayreuth_min_lat, bayreuth_max_lat)
  ride.to_lng = rand_in_range(bayreuth_min_lng, bayreuth_max_lng)

  ride.from_lng = bayreuth_uni_lng
  ride.from_lat = bayreuth_uni_lat
  ride.from_address = bayreuth_uni_address

  geocode_address(ride)

  unless ride.save
    print ride.errors
    binding.pry
  end

  ride.seats.times do
    offer = Offer.new
    offer.ride = ride
    request = Request.where(direction: "from").sample
    while request.user == ride.user #to avoid the driver also being a passenger
      request = Request.all.sample
    end
    offer.request_id = request.id
    offer.confirmed = [true, false].sample
    unless offer.save
      print offer.errors
      binding.pry
    end
  end
end

#ADMIN

puts "Creating admin user"

user = User.new
user.first_name = "Anton"
user.last_name = "Castell"
user.email = "admin@email.com"
user.age = 29
user.remote_photo_url = USER_IMAGES[2]
user.hobby = "netflix & chill"
user.music = "Deutsch Rap, Blues"
user.semester = 14
user.course = "Türsteherei"
user.password = "123456"
user.admin = true
unless user.save
  print user.errors
  binding.pry
end



