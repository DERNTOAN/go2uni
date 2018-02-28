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
        scored_requests<< [request, score]
      else
        scored_requests<< [request, 0]
      end
    end
    sorted = scored_requests.sort_by do |array|
      - array[1]
    end
    return sorted[0..7].map{|element| element[0]}
  end

  def calculate_score(request, ride)
    (request.from_lat - ride.from_lat).abs + (request.to_lat - ride.to_lat).abs + (request.from_lng - ride.from_lng).abs + (request.to_lng - ride.to_lng).abs
  end
end
