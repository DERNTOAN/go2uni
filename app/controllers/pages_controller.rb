class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index]
  before_action :update_session, only: [:index, :final]

  def index
    @location = session[:location]
    @rides = policy_scope(Ride)
    @rides = @rides.where.not(from_lng: nil, from_lat: nil, to_lng: nil, to_lat: nil)
    @mapcenter = {
      lat: @location["lat"],
      lng: @location["lng"]
    } if session[:location]
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


  def home
  end

  def final
  end

  private

  def update_session
    if params[:lat] != nil
      session[:location] = { "lat" => params[:lat].to_f, "lng" => params[:lng].to_f }
    end
  end

end
