class SuggestionsController < ApplicationController
  def index
    @requests = policy_scope(Request)
    @ride = Ride.where(id: params["ride_id"]).first
    @suggestions = find_suggestions
  end


  private

  def find_suggestions
    scored_requests = []

    @requests.each do |request|
      if @ride.uni == request.uni && @ride.direction == request.direction && request.start_time < @ride.departure_time && request.stop_time > @ride.departure_time && request.user != @ride.user
        if calculate_score(request, @ride)
          data = compute_duration_and_distance(request, @ride)
          scored_requests<< [request, data] if data[:duration] <= 1200
        end
      end
    end
    sorted = scored_requests.sort_by { |array| array[1][:duration] }
    sorted.uniq! { |request| request[0][:user_id] }
    return sorted
  end

  def calculate_score(request, ride)
    max_distance = 1
    coordinates = get_lat_and_long(request, ride)
    coordinates[:request_lat]
    p distance_in_km = Math.sqrt( (((coordinates[:request_lat]-coordinates[:ride_lat]) * 71.44) ** 2) + (((coordinates[:request_lng] - coordinates[:ride_lng]) * 111.13 ) ** 2) )
    return distance_in_km < max_distance
  end
    # (request.from_lat - ride.from_lat).abs + (request.to_lat - ride.to_lat).abs + (request.from_lng - ride.from_lng).abs + (request.to_lng - ride.to_lng).abs

  def get_lat_and_long(request, ride)
    if request.direction == "to"
      request_lat = request.from_lat
      request_lng = request.from_lng
      ride_lat = ride.from_lat
      ride_lng = ride.from_lng
    else
      request_lat = request.to_lat
      request_lng = request.to_lng
      ride_lat = ride.to_lat
      ride_lng = ride.to_lng
    end
    return {
      request_lat: request_lat,
      request_lng: request_lng,
      ride_lat: ride_lat,
      ride_lng: ride_lng
    }
  end

  def compute_duration_and_distance(request, ride)
    rep = {}
    if(request.from_lat && request.from_lng && ride.from_lat && ride.from_lng)
      url_ride= "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{request.from_lat},#{request.from_lng}&destinations=#{ride.from_lat},#{ride.from_lng}&mode=driving&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
      distances_ride = JSON.parse(open(url_ride).read)
      unless distances_ride["rows"][0]["elements"][0]["status"] == "ZERO_RESULTS"
        rep[:duration] = distances_ride["rows"][0]["elements"][0]["duration"]["value"]
        rep[:distance] = distances_ride["rows"][0]["elements"][0]["distance"]["value"]
      end
    else
      rep[:duration] = 9999999
      rep[:distance] = 9999999
    end
    return rep
  end
end
