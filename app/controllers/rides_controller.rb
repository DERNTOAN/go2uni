class RidesController < ApplicationController
  before_action :update_session

  def index
    @location = session[:location]
    @rides = policy_scope(Ride)
    @rides = @rides.where.not(from_lng: nil, from_lat: nil, to_lng: nil, to_lat: nil)

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
    @mapbounds = {
      min: { lat: @rides.map { |ride| ride.from_lat }.max, lng: @rides.map { |ride| ride.from_lng }.min },
      max: { lat: @rides.map { |ride| ride.from_lat }.min, lng: @rides.map { |ride| ride.from_lng }.max }
    }

    @ride = Ride.new
    @request = Request.new
  end

  def show
    @ride = Ride.find(params[:id])
    authorize @ride
    @offers = Offer.where(ride: @ride)
    @requests = @offers.map(&:request)
    @marker_from_driver = {
      lng: @ride.from_lng,
      lat: @ride.from_lat,
      icon: 'car.gif'
    }

    @marker_to = {
      lng: @ride.to_lng,
      lat: @ride.to_lat
    }

    @passengers = @requests.map do |request|
      {

      from: {
        lng: request.from_lng,
        lat: request.from_lat,
      },

      avatar: request.user.photo.url
      }




    end

    lats = [ @ride.from_lat, @ride.to_lat, @passengers.map { |passenger| passenger[:from][:lat] }].flatten
    lngs = [ @ride.from_lng, @ride.to_lng, @passengers.map { |passenger| passenger[:from][:lng] }].flatten


    @mapbounds = {
      min: { lat: lats.max, lng: lngs.min },
      max: { lat: lats.min, lng: lngs.max }
    }
  end

  def new
    @ride = Ride.new
    authorize @ride
  end

  def create
    uni = params.require(:ride)["uni"]
    if params.require(:ride)["direction"] == "from"
      to_address =  params.require(:ride)[:from_address]
      from_address = uni_address(uni)
    else
      to_address =  uni_address(uni)
      from_address = params.require(:ride)[:from_address]
    end
    params.require(:ride)[:from_address] = from_address
    params.require(:ride)[:to_address] = to_address

    @ride = Ride.create(ride_params)
    authorize @ride
    @ride.user_id = current_user.id

    if @ride.save
      redirect_to ride_suggestions_path(@ride)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def ride_params
    params.require(:ride).permit(:user_id, :seats,:from_address, :to_address, :departure_time, :uni, :direction)
  end

  def uni_address(uni)
    locations = {
      "bayreuth" => "Universitätsstraße 30, 95447 Bayreuth",
      "tuebingen"=> "Geschwister-Scholl-Platz, 72074 Tübingen",
      "aachen" => "Templergraben 55, 52062 Aachen"
    }

    return locations[uni]
  end

  def update_session
    if params[:location] != nil
      session[:location] = params[:location]
    end
  end
end
