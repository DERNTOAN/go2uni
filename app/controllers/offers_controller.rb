class OffersController < ApplicationController
  def create
    params.keys.each do |key|
      if key.to_i != 0
        offer = Offer.new(ride_id: params["ride_id"], request_id: key.to_i, confirmed: nil)
        raise unless offer.save
        authorize offer
      end
    end

    # offer = Offer.new(ride_id: params["ride_id"], request_id: params["request_id"], confirmed: nil)
    # raise unless offer.save
    # authorize offer

    redirect_to ride_path(params["ride_id"])
  end
end
