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
    @offers = Offer.where(request: @myrequest).where(confirmed: nil)
    @rides = @offers.map { |offer| offer.ride }
    authorize @myrequest


    @marker_from_passenger = {
      lng: @myrequest.from_lng,
      lat: @myrequest.from_lat,
      avatar: @myrequest.user.photo.url
    }

    @walking_distances = @rides.map do |ride|
      url_walk_to_car= "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{@myrequest.from_lat},#{@myrequest.from_lng}&destinations=#{ride.from_lat},#{ride.from_lng}&mode=walking&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
      distances_walk_to_car = JSON.parse(open(url_walk_to_car).read)

      url_ride= "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{ride.from_lat},#{ride.from_lng}&destinations=#{ride.to_lat},#{ride.to_lng}&mode=driving&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
      distances_ride = JSON.parse(open(url_ride).read)


      url_walk_to_dest= "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{ride.to_lat},#{ride.to_lng}&destinations=#{@myrequest.to_lat},#{@myrequest.to_lng}&mode=walking&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
      distances_walk_to_dest = JSON.parse(open(url_walk_to_dest).read)

      unless([distances_walk_to_car["rows"][0]["elements"][0]["status"],
        distances_ride["rows"][0]["elements"][0]["status"],
        distances_walk_to_dest["rows"][0]["elements"][0]["status"]].include? "ZERO_RESULTS")
      {ride: ride,
      distance_matrix: {
        walk_to_car_duration_text: distances_walk_to_car["rows"][0]["elements"][0]["duration"]["text"],
        walk_to_car_duration_s: distances_walk_to_car["rows"][0]["elements"][0]["duration"]["value"],
        walk_to_car_distance_m: distances_walk_to_car["rows"][0]["elements"][0]["distance"]["value"],
        ride_duration_text: distances_ride["rows"][0]["elements"][0]["duration"]["text"],
        ride_duration_s: distances_ride["rows"][0]["elements"][0]["duration"]["value"],
        ride_distance_m: distances_ride["rows"][0]["elements"][0]["distance"]["value"],
        walk_to_dest_duration_text: distances_walk_to_dest["rows"][0]["elements"][0]["duration"]["text"],
        walk_to_dest_duration_s: distances_walk_to_dest["rows"][0]["elements"][0]["duration"]["value"],
        walk_to_dest_distance_m: distances_walk_to_dest["rows"][0]["elements"][0]["distance"]["value"],
      }
    }
    end


  end


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
