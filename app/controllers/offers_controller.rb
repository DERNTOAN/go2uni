class OffersController < ApplicationController
  def create
    offer = Offer.new(ride_id: params["ride_id"], request_id: params["request_id"], confirmed: nil)
    raise unless offer.save
    authorize offer

    redirect_to ride_path(params["ride_id"])
  end
end
