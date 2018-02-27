class SuggestionsController < ApplicationController
  def index
    @requests = policy_scope(Request)
    @ride = Ride.where(id: params["ride_id"]).first
    raise
  end


  private

  def find_suggestions
    suggestions = []
    @request.each do |request|
      if request.from_address
    end
  end
end
