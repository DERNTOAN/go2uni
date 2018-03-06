class MyrequestsController < ApplicationController
  def index
    @myrequests = policy_scope(Request).where("user_id = #{current_user.id}")
    @offers = find_offers
    @markers_from = @offers.map do |offer|
      {
        lng: offer.ride.from_lng,
        lat: offer.ride.from_lat,
      }
    end
    if @offers != []
      @mapbounds = {
        min: { lat: @offers.map { |offer| offer.ride.from_lat }.max, lng: @offers.map { |offer| offer.ride.from_lng }.min },
        max: { lat: @offers.map { |offer| offer.ride.from_lat }.min, lng: @offers.map { |offer| offer.ride.from_lng }.max }
      }
    elsif @myrequests != []
      p @myrequests
      @markers_from = [{
        lng: @myrequests.first.from_lng,
        lat: @myrequests.first.from_lat,
      }]
      @mapbounds = {
        min: { lat: @myrequests.map { |myrequest| myrequest.from_lat }.max, lng: @myrequests.map { |myrequest| myrequest.from_lng }.min },
        max: { lat: @myrequests.map { |myrequest| myrequest.from_lat }.min, lng: @myrequests.map { |myrequest| myrequest.from_lng }.max }
      }

    end
  end

  def show
    @myrequest = Request.find(params[:id])
    @offers = Offer.where(request: @myrequest)
    @rides = @offers.map { |offer| offer.ride }
    authorize @myrequest


    @marker_from_passenger = {
      lng: @myrequest.from_lng,
      lat: @myrequest.from_lat,
      avatar: @myrequest.user.photo.url
    }


    @marker_to = {
      lng: @myrequest.to_lng,
      lat: @myrequest.to_lat
    }

    @drivers = @rides.map do |ride|
      {
        from: {
        lng: ride.from_lng,
        lat: ride.from_lat,
        },

        to: {
          lng: ride.to_lng,
          lat: ride.to_lat,
        },

        avatar: ride.user.photo.url,
        user_id: ride.user.id,
        ride_id: ride.id,
        first_name: ride.user.first_name,
        last_name: ride.user.last_name
      }
    end
  end

  private

  def find_offers
    matching_offers = []
    offers = Offer.all
    offers.each do |offer|
      if offer.request.user_id == current_user.id
        matching_offers << offer
      end
    end
    matching_offers
  end

end
