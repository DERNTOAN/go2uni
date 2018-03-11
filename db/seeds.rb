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


def distance_in_km(address_lat, address_lng, uni_lat, uni_lng)
  Math.sqrt( (((address_lat-uni_lat) * 71.44) ** 2) + (((address_lng - uni_lng) * 111.13 ) ** 2))
end

################################################################################
number_to_requests = 90
number_from_requests = 90

number_to_rides = 20
number_from_rides = 1

#from and to min and max numbers for the map coordinates
bayreuth_min_lat = 49.934095
bayreuth_min_lng = 11.564235

bayreuth_max_lat = 49.949671
bayreuth_max_lng = 11.592198

braunschweig_min_lat = 52.236956
braunschweig_min_lng = 10.473358

braunschweig_max_lat = 52.278918
braunschweig_max_lng = 10.550506

aachen_min_lat = 50.759709
aachen_min_lng = 6.037091

aachen_max_lat = 50.808091
aachen_max_lng = 6.109277

#Bayreuth uni coordinates
bayreuth_uni_lat = 49.928795
bayreuth_uni_lng = 11.585852

braunschweig_uni_lat = 52.273496
braunschweig_uni_lng = 10.529681

aachen_uni_lat = 50.780424
aachen_uni_lng = 6.065547

bayreuth_uni_address = "Universitätsstraße 30, Bayreuth"
braunschweig_uni_address = "Universitätsplatz 2, Braunschweig"
aachen_uni_address = "Templergraben 55, Aachen"

time_frame = 7.days

min_route_distance = 0.5



################################################################################
delete_users = false
delete_rides = false
delete_requests = true
delete_offers = false

seed_users = false
seed_rides = false
seed_requests = true
seed_offers = false
seed_admin = false
seed_demo = false

################################################################################
puts "clearing database"

if delete_rides
  Offer.destroy_all
  Ride.destroy_all
end
if delete_requests
  Offer.destroy_all
  Request.destroy_all
end
if delete_users
  User.destroy_all
end

puts "cleared"

#################################################################################
if seed_users
  puts "creating #{USER_IMAGES.length} users"

  USER_IMAGES.each_with_index do |photo_url, i|
    user = User.new
    user.first_name = USER_NAMES[i]
    user.last_name = Faker::Name.last_name
    user.email = "#{USER_NAMES[i]}@email.com"
    user.age = rand(20) + 16
    user.remote_photo_url = photo_url
    user.password = "123456"
    user.description = USER_DESCRIPTIONS[i]
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
end

################################################################################
anton = User.find_by_first_name "Anton"
#REQUESTS
if seed_requests

  #BAYREUTH
  puts "creating #{number_to_requests} requests to Bayreuth"

  number_to_requests.times do
    request = Request.new
    request.direction = "to"

    request.start_time = rand(time_frame).seconds.from_now
    request.start_time.change(hour: 6)
    request.start_time.change(hour: 10) if request.start_time.day == 12
    request.stop_time = request.start_time
    request.stop_time.change(hour:22)

    request.user_id = User.all.sample.id
 if request.user_id = anton.id
      request.user_id = User.all.sample.id
    end
    request.to_lng = bayreuth_uni_lng
    request.to_lat = bayreuth_uni_lat

    request.from_lat = rand_in_range(bayreuth_min_lat, bayreuth_max_lat)
    request.from_lng = rand_in_range(bayreuth_min_lng, bayreuth_max_lng)

    while (distance_in_km(request.from_lat, request.from_lng, request.to_lat, request.to_lng) < min_route_distance)
      request.from_lat = rand_in_range(bayreuth_min_lat, bayreuth_max_lat)
      request.from_lng = rand_in_range(bayreuth_min_lng, bayreuth_max_lng)
    end

    request.to_address = bayreuth_uni_address
    geocode_address(request)

    request.uni = "bayreuth"

    unless request.save
      print request.errors
      binding.pry
    end
  end

  puts "creating #{number_from_requests} requests from Bayreuth"

  number_from_requests.times do
    request = Request.new
    request.direction = "from"

    request.start_time = rand(time_frame).seconds.from_now
    request.start_time.change(hour: 6)
    request.stop_time = request.start_time
    request.stop_time.change(hour:22)

    request.user_id = User.all.sample.id
    if request.user_id = anton.id
      request.user_id = User.all.sample.id
    end

    request.to_lat = rand_in_range(bayreuth_min_lat, bayreuth_max_lat)
    request.to_lng = rand_in_range(bayreuth_min_lng, bayreuth_max_lng)
    request.from_lng = bayreuth_uni_lng
    request.from_lat = bayreuth_uni_lat

    while (distance_in_km(request.from_lat, request.from_lng, request.to_lat, request.to_lng) < min_route_distance)
      request.from_lat = rand_in_range(bayreuth_min_lat, bayreuth_max_lat)
      request.from_lng = rand_in_range(bayreuth_min_lng, bayreuth_max_lng)
    end

    request.from_address = bayreuth_uni_address
    geocode_address(request)

    request.uni = "bayreuth"

    unless request.save
      print request.errors
      binding.pry
    end
  end

  #Braunschweig
  puts "creating #{number_to_requests} requests to braunschweig"

  number_to_requests.times do
    request = Request.new
    request.direction = "to"

    request.start_time = rand(time_frame).seconds.from_now
    request.start_time.change(hour: 6)
    request.stop_time = request.start_time
    request.stop_time.change(hour:22)

    request.user_id = User.all.sample.id
    if request.user_id = anton.id
      request.user_id = User.all.sample.id
    end
    request.to_lng = braunschweig_uni_lng
    request.to_lat = braunschweig_uni_lat

    request.from_lat = rand_in_range(braunschweig_min_lat, braunschweig_max_lat)
    request.from_lng = rand_in_range(braunschweig_min_lng, braunschweig_max_lng)

    while (distance_in_km(request.from_lat, request.from_lng, request.to_lat, request.to_lng) < min_route_distance)
      request.from_lat = rand_in_range(braunschweig_min_lat, braunschweig_max_lat)
      request.from_lng = rand_in_range(braunschweig_min_lng, braunschweig_max_lng)
    end

    request.to_address = braunschweig_uni_address
    geocode_address(request)

    request.uni = "braunschweig"

    unless request.save
      print request.errors
      binding.pry
    end
  end

  puts "creating #{number_from_requests} requests from braunschweig"

  number_from_requests.times do
    request = Request.new
    request.direction = "from"

    request.start_time = rand(time_frame).seconds.from_now
    request.start_time.change(hour: 6)
    request.stop_time = request.start_time
    request.stop_time.change(hour:22)

    request.user_id = User.all.sample.id
    if request.user_id = anton.id
      request.user_id = User.all.sample.id
    end

    request.to_lat = rand_in_range(braunschweig_min_lat, braunschweig_max_lat)
    request.to_lng = rand_in_range(braunschweig_min_lng, braunschweig_max_lng)
    request.from_lng = braunschweig_uni_lng
    request.from_lat = braunschweig_uni_lat

    while (distance_in_km(request.from_lat, request.from_lng, request.to_lat, request.to_lng) < min_route_distance)
      request.from_lat = rand_in_range(braunschweig_min_lat, braunschweig_max_lat)
      request.from_lng = rand_in_range(braunschweig_min_lng, braunschweig_max_lng)
    end

    request.from_address = braunschweig_uni_address
    geocode_address(request)

    request.uni = "braunschweig"

    unless request.save
      print request.errors
      binding.pry
    end
  end


  #Aachen
  puts "creating #{number_to_requests} requests to aachen"

  number_to_requests.times do
    request = Request.new
    request.direction = "to"

    request.start_time = rand(time_frame).seconds.from_now
    request.start_time.change(hour: 6)
    request.stop_time = request.start_time
    request.stop_time.change(hour:22)

    request.user_id = User.all.sample.id
    if request.user_id = anton.id
      request.user_id = User.all.sample.id
    end
    request.to_lng = aachen_uni_lng
    request.to_lat = aachen_uni_lat

    request.from_lat = rand_in_range(aachen_min_lat, aachen_max_lat)
    request.from_lng = rand_in_range(aachen_min_lng, aachen_max_lng)

    while (distance_in_km(request.from_lat, request.from_lng, request.to_lat, request.to_lng) < min_route_distance)
      request.from_lat = rand_in_range(aachen_min_lat, aachen_max_lat)
      request.from_lng = rand_in_range(aachen_min_lng, aachen_max_lng)
    end

    request.to_address = aachen_uni_address
    geocode_address(request)

    request.uni = "aachen"

    unless request.save
      print request.errors
      binding.pry
    end
  end

  puts "creating #{number_from_requests} requests from aachen"

  number_from_requests.times do
    request = Request.new
    request.direction = "from"

    request.start_time = rand(time_frame).seconds.from_now
    request.start_time.change(hour: 6)
    request.stop_time = request.start_time
    request.stop_time.change(hour:22)

    request.user_id = User.all.sample.id
    if request.user_id = anton.id
      request.user_id = User.all.sample.id
    end

    request.to_lat = rand_in_range(aachen_min_lat, aachen_max_lat)
    request.to_lng = rand_in_range(aachen_min_lng, aachen_max_lng)
    request.from_lng = aachen_uni_lng
    request.from_lat = aachen_uni_lat

    while (distance_in_km(request.from_lat, request.from_lng, request.to_lat, request.to_lng) < min_route_distance)
      request.from_lat = rand_in_range(aachen_min_lat, aachen_max_lat)
      request.from_lng = rand_in_range(aachen_min_lng, aachen_max_lng)
    end

    request.from_address = aachen_uni_address
    geocode_address(request)

    request.uni = "aachen"

    unless request.save
      print request.errors
      binding.pry
    end
  end
end
################################################################################
#RIDES
if seed_rides

      #bayreuth
      puts "creating #{number_to_rides} rides to bayreuth"

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

              while (distance_in_km(ride.from_lat, ride.from_lng, ride.to_lat, ride.to_lng) < min_route_distance)
                ride.from_lat = rand_in_range(bayreuth_min_lat, bayreuth_max_lat)
                ride.from_lng = rand_in_range(bayreuth_min_lng, bayreuth_max_lng)
              end

              ride.to_address = bayreuth_uni_address

              ride.uni = "bayreuth"

              geocode_address(ride)

              unless ride.save
                print ride.erros
                binding.pry
              end
            end

            puts "creating #{number_from_rides} rides from bayreuth"

            number_from_rides.times do
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

              while (distance_in_km(ride.from_lat, ride.from_lng, ride.to_lat, ride.to_lng) < min_route_distance)
                ride.from_lat = rand_in_range(bayreuth_min_lat, bayreuth_max_lat)
                ride.from_lng = rand_in_range(bayreuth_min_lng, bayreuth_max_lng)
              end

              ride.uni = "bayreuth"

              geocode_address(ride)

              unless ride.save
                print ride.errors
                binding.pry
              end
            end

      #braunschweig
      puts "creating #{number_to_rides} rides to braunschweig"

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

              ride.from_lat = rand_in_range(braunschweig_min_lat, braunschweig_max_lat)
              ride.from_lng = rand_in_range(braunschweig_min_lng, braunschweig_max_lng)

              ride.to_lng = braunschweig_uni_lng
              ride.to_lat = braunschweig_uni_lat

              while (distance_in_km(ride.from_lat, ride.from_lng, ride.to_lat, ride.to_lng) < min_route_distance)
                ride.from_lat = rand_in_range(braunschweig_min_lat, braunschweig_max_lat)
                ride.from_lng = rand_in_range(braunschweig_min_lng, braunschweig_max_lng)
              end

              ride.to_address = braunschweig_uni_address

              ride.uni = "braunschweig"

              geocode_address(ride)

              unless ride.save
                print ride.erros
                binding.pry
              end
            end

            puts "creating #{number_from_rides} rides from braunschweig"

            number_from_rides.times do
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

              ride.to_lat = rand_in_range(braunschweig_min_lat, braunschweig_max_lat)
              ride.to_lng = rand_in_range(braunschweig_min_lng, braunschweig_max_lng)

              ride.from_lng = braunschweig_uni_lng
              ride.from_lat = braunschweig_uni_lat
              ride.from_address = braunschweig_uni_address

              while (distance_in_km(ride.from_lat, ride.from_lng, ride.to_lat, ride.to_lng) < min_route_distance)
                ride.from_lat = rand_in_range(braunschweig_min_lat, braunschweig_max_lat)
                ride.from_lng = rand_in_range(braunschweig_min_lng, braunschweig_max_lng)
              end

              ride.uni = "braunschweig"

              geocode_address(ride)

              unless ride.save
                print ride.errors
                binding.pry
              end
            end

      #aachen
      puts "creating #{number_to_rides} rides to aachen"

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

              ride.from_lat = rand_in_range(aachen_min_lat, aachen_max_lat)
              ride.from_lng = rand_in_range(aachen_min_lng, aachen_max_lng)

              ride.to_lng = aachen_uni_lng
              ride.to_lat = aachen_uni_lat

              while (distance_in_km(ride.from_lat, ride.from_lng, ride.to_lat, ride.to_lng) < min_route_distance)
                ride.from_lat = rand_in_range(aachen_min_lat, aachen_max_lat)
                ride.from_lng = rand_in_range(aachen_min_lng, aachen_max_lng)
              end

              ride.to_address = aachen_uni_address

              ride.uni = "aachen"

              geocode_address(ride)

              unless ride.save
                print ride.erros
                binding.pry
              end
            end

            puts "creating #{number_from_rides} rides from aachen"

            number_from_rides.times do
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

              ride.to_lat = rand_in_range(aachen_min_lat, aachen_max_lat)
              ride.to_lng = rand_in_range(aachen_min_lng, aachen_max_lng)

              ride.from_lng = aachen_uni_lng
              ride.from_lat = aachen_uni_lat
              ride.from_address = aachen_uni_address

              while (distance_in_km(ride.from_lat, ride.from_lng, ride.to_lat, ride.to_lng) < min_route_distance)
                ride.from_lat = rand_in_range(aachen_min_lat, aachen_max_lat)
                ride.from_lng = rand_in_range(aachen_min_lng, aachen_max_lng)
              end

              ride.uni = "aachen"

              geocode_address(ride)

              unless ride.save
                print ride.errors
                binding.pry
              end
            end
          end

################################################################################
#DEMO
if seed_demo
  henrik = User.find_by_first_name "Henrik"
  vini = User.find_by_first_name "Vini"
  nico = User.find_by_first_name "Nico"

  julian = User.find_by_first_name "Julian"
  nick = User.find_by_first_name "Nick"
  simon = User.find_by_first_name "Simon"

  anton = User.find_by_first_name "Anton"

  alice = User.find_by_first_name "Alice"
  martin = User.find_by_first_name "Martin"
  arda = User.find_by_first_name "Arda"

  request_henrik = Request.new(
    direction: "to",
    uni: "bayreuth",
    to_address: bayreuth_uni_address,
    to_lat: bayreuth_uni_lat,
    to_lng: bayreuth_uni_lng,
    start_time: DateTime.now.change(day: 12, hour: 6),
    stop_time: DateTime.now.change(day: 12, hour: 22)
    )
  request_vini = Request.new(
    direction: "to",
    uni: "bayreuth",
    to_address: bayreuth_uni_address,
    to_lat: bayreuth_uni_lat,
    to_lng: bayreuth_uni_lng,
    start_time: DateTime.now.change(day: 12, hour: 6),
    stop_time: DateTime.now.change(day: 12, hour: 22)
    )
  request_nico = Request.new(
    direction: "to",
    uni: "bayreuth",
    to_address: bayreuth_uni_address,
    to_lat: bayreuth_uni_lat,
    to_lng: bayreuth_uni_lng,
    start_time: DateTime.now.change(day: 12, hour: 6),
    stop_time: DateTime.now.change(day: 12, hour: 22)
    )
  request_julian = Request.new(
    direction: "to",
    uni: "bayreuth",
    to_address: bayreuth_uni_address,
    to_lat: bayreuth_uni_lat,
    to_lng: bayreuth_uni_lng,
    start_time: DateTime.now.change(day: 12, hour: 6),
    stop_time: DateTime.now.change(day: 12, hour: 22)
    )
  request_nick = Request.new(
    direction: "to",
    uni: "bayreuth",
    to_address: bayreuth_uni_address,
    to_lat: bayreuth_uni_lat,
    to_lng: bayreuth_uni_lng,
    start_time: DateTime.now.change(day: 12, hour: 6),
    stop_time: DateTime.now.change(day: 12, hour: 22)
    )
  request_simon = Request.new(
    direction: "to",
    uni: "bayreuth",
    to_address: bayreuth_uni_address,
    to_lat: bayreuth_uni_lat,
    to_lng: bayreuth_uni_lng,
    start_time: DateTime.now.change(day: 12, hour: 6),
    stop_time: DateTime.now.change(day: 12, hour: 22)
    )

  request_henrik.user = henrik
  request_vini.user = vini
  request_nico.user = nico
  request_julian.user = julian
  request_nick.user = nick
  request_simon.user = simon

  request_henrik.from_address = "Siegfried-Wagner-Allee, Bayreuth"
  request_vini.from_address = "Tannhäuserstraße, Bayreuth"
  request_nico.from_address = "Parsifalstraße, Bayreuth"
  request_julian.from_address = "An der Bürgerreuth 8, Bayreuth"
  request_nick.from_address = "Knappertsbuschstraße 4, Bayreuth"
  request_simon.from_address = "Tristanstraße, Bayreuth"

  geocode_address(request_henrik)
  geocode_address(request_vini)
  geocode_address(request_nico)
  geocode_address(request_julian)
  geocode_address(request_nick)
  geocode_address(request_simon)

  binding.pry unless request_henrik.save
  binding.pry unless request_vini.save
  binding.pry unless request_nico.save
  binding.pry unless request_julian.save
  binding.pry unless request_nick.save
  binding.pry unless request_simon.save


  ride1 = Ride.new(
    direction: "to",
    uni: "bayreuth",
    to_address: bayreuth_uni_address,
    to_lat: bayreuth_uni_lat,
    to_lng: bayreuth_uni_lng,
    seats: 4
    )
  ride2 = Ride.new(
    direction: "to",
    uni: "bayreuth",
    to_address: bayreuth_uni_address,
    to_lat: bayreuth_uni_lat,
    to_lng: bayreuth_uni_lng,
    seats: 4
    )
  ride3 = Ride.new(
    direction: "to",
    uni: "bayreuth",
    to_address: bayreuth_uni_address,
    to_lat: bayreuth_uni_lat,
    to_lng: bayreuth_uni_lng,
    seats: 4
    )

  ride1.departure_time = DateTime.now.change(day: 13, hour: 8, min: 45)
  ride2.departure_time = DateTime.now.change(day: 13, hour: 8, min: 30)
  ride3.departure_time = DateTime.now.change(day: 13, hour: 9, min: 15)
  ride1.user = arda
  ride2.user = alice
  ride3.user = martin

  ride1.from_address="Tannhäuserstraße, Bayreuth"
  ride2.from_address="Parsifalstraße, Bayreuth"
  ride3.from_address="An der Bürgerreuth 8, Bayreuth"

  binding.pry unless ride1.save
  binding.pry unless ride2.save
  binding.pry unless ride3.save
end


#own request
own_request = Request.new(
  user: anton,
  direction: "to",
  uni: "bayreuth",
  from_address: "Festspielhügel, Bayreuth",
  from_lat: 49.960191,
  from_lng: 11.578925,
  to_address: bayreuth_uni_address,
  to_lat: bayreuth_uni_lat,
  to_lng: bayreuth_uni_lng,
  start_time: DateTime.now.change(day: 13, hour: 8),
  stop_time: DateTime.now.change(day: 13, hour: 9, min: 30)
  )
binding.pry unless own_request.save

#offers
o1 = Offer.new
o1.ride = ride1
o1.request = own_request
binding.pry unless o1.save

o2 = Offer.new
o2.ride = ride2
o2.request = own_request
binding.pry unless o2.save

o3 = Offer.new
o3.ride = ride3
o3.request = own_request
binding.pry unless o3.save

#ADMIN
if seed_admin
  puts "Creating admin user"

  user = User.new
  user.first_name = "Anton"
  user.last_name = "Castell"
  user.email = "admin@email.com"
  user.age = 29
  user.remote_photo_url = USER_IMAGES[2]
  user.hobby = "Netflix, Chill"
  user.music = "Deutsch Rap, Blues"
  user.semester = 14
  user.course = "Mikrobiologie"
  user.password = "123456"
  user.admin = true
  unless user.save
    print user.errors
    binding.pry
  end

end

