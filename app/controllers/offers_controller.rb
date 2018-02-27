class OffersController < ApplicationController
  def create
    offer = Offer.create(user_id: current_user, ride_id: params["ride_id"], confirmed: false)
    authorize offer
    redirect_to ride_path(params["ride_id"])
  end
end
