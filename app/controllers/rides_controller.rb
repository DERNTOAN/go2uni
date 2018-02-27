class RidesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @rides = policy_scope(Ride)
    @rides = @rides.where.not(from_lng: nil, from_lat: nil, to_lng: nil, to_lat: nil)

    @ride = Ride.new

    @markers_from = @rides.map do |ride|
      {
        lng: ride.from_lng,
        lat: ride.from_lat,
      }
    end

    @markers_to = @rides.map do |ride|
      {
        lng: ride.to_lng,
        lat: ride.to_lat
      }
    end

    @request = Request.new
  end

  def show
    @ride = Ride.find(params[:id])
    authorize @ride
    @requests = Offer.where(ride_id: @ride.id).where(confirmed: true).map(&:request)
  end

  def new
    @ride = Ride.new
    authorize @ride
  end

  def create
    @ride = Ride.create(ride_params)
    authorize @ride
    @ride.user_id = current_user.id
    @ride.save
    redirect_to ride_suggestions_path(@ride)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def ride_params
    params.require(:ride).permit(:user_id, :seats,:from_address, :to_address, :departure_time)
  end
end
