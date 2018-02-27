class RidesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @rides = policy_scope(Ride)
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
    params.require(:ride).permit(:user_id, :seats, :departure_time, :from_lng, :from_lat, :to_lng, :to_lat)
  end
end
