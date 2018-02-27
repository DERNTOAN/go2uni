class OffersController < ApplicationController
  def create
    @offer = Offer.create(ride_id: params["ride_id"], user_id: current_user.id, confirmed: false)
    authorize @offer
    redirect_to ride_path(params["ride_id"])
  end
end