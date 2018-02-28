class MyrequestsController < ApplicationController
  def index
    @myrequests = policy_scope(Request).where("user_id = #{params[:id]}")
    @offers = Offer.all
    @markers_from = @myrequests.map do |myrequest|
      {
        lng: myrequest.from_lng,
        lat: myrequest.from_lat,
      }
    end

    @markers_to = @myrequests.map do |myrequest|
      {
        lng: myrequest.to_lng,
        lat: myrequest.to_lat
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
            id: ride.user.id,
            first_name: ride.user.first_name,
            last_name: ride.user.last_name
          }
        end

      end
  end
