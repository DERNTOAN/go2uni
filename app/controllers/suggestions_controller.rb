class SuggestionsController < ApplicationController
  def index
    @requests = policy_scope(Request)
    @ride = Ride.where(id: params["ride_id"]).first
    raise
  end
end
