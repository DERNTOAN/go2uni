class SuggestionsController < ApplicationController
  def index
    @requests = policy_scope(Request)
    @ride = Ride.where(id: params["ride_id"]).first
    @suggestions = find_suggestions
  end


  private

  def find_suggestions
    suggestions = []
    @requests.each do |request|
      # geocoded_request_from_address = Geocoder.search(request.from_address)
      # raise
      # geocoded_request_to_address = Geocoder.coordinates(request.to_address)
      # geocoded_ride_from_address = Geocoder.coordinates(@ride.from_address)
      # geocoded_ride_to_address = Geocoder.coordinates(@ride.to_address)
      # g = geocoded_request_from_address.near(geocoded_ride_from_address, 0.5)
      suggestions << request
      # end
    end
    suggestions
  end
end
