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
      if request.start_time < @ride.departure_time && request.stop_time > @ride.departure_time
        score = calculate_score(request, @ride)
 #       data = compute_duration_and_distance(request, @ride)
 #       scored_requests<< [request, score, data] if data[:duration] <= 1800
        scored_requests<< [request, score]
      end
    end
    sorted = scored_requests.sort_by { |array| - array[1] }
    return sorted[0..7]
  end

  def calculate_score(request, ride)
    (request.from_lat - ride.from_lat).abs + (request.to_lat - ride.to_lat).abs + (request.from_lng - ride.from_lng).abs + (request.to_lng - ride.to_lng).abs
  end

  def compute_duration_and_distance(request, ride)
    rep = {}
    if(request.from_lat && request.from_lng && ride.from_lat && ride.from_lng)
      url_ride= "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{request.from_lat},#{request.from_lng}&destinations=#{ride.from_lat},#{ride.from_lng}&mode=driving&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
      distances_ride = JSON.parse(open(url_ride).read)
      unless distances_ride["rows"][0]["elements"][0]["status"] == "ZERO RESULTS"
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
