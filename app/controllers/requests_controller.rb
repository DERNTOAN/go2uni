class RequestsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @requests = policy_scope(Request)
    @requests = @requests.where.not(from_lng: nil, from_lat: nil, to_lng: nil, to_lat: nil)

    @markers_from = @requests.map do |request|
      {
        lng: request.from_lng,
        lat: request.from_lat,
      }
    end

    @markers_to = @requests.map do |request|
      {
        lng: request.to_lng,
        lat: request.to_lat
      }
    end

    @ride = Ride.new
  end

  def show
    @request = Request.find(params[:id])
    authorize @request
  end

  def new
    @request = Request.new
    authorize @request

  end

  def create
    uni = params.require(:request)["uni"]
    if params.require(:request)["direction"] == "from"
      to_address =  params.require(:request)[:from_address]
      from_address = uni_address(uni)
    else
      to_address =  uni_address(uni)
      from_address = params.require(:request)[:from_address]
    end
    params.require(:request)[:from_address] = from_address
    params.require(:request)[:to_address] = to_address

    @request = Request.create(request_params)
    authorize @request
    @request.user_id = current_user.id
    if @request.save
      redirect_to myrequest_path(@request)
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

  def request_params
    stop = DateTime.parse(params.require(:request)[:stop_time])
    start = DateTime.parse(params.require(:request)[:start_time])
    params.require(:request)[:stop_time] = start.change(hour: stop.hour, min:stop.minute).to_s
    params.require(:request).permit(:user_id, :start_time, :stop_time,:from_address, :to_address, :uni, :direction)
  end

  def uni_address(uni)
    locations = {
      "bayreuth" => "Universitätsstraße 30, Bayreuth",
      "braunschweig"=> "Universitätsplatz 2, Braunschweig",
      "aachen" => "Templergraben 55, Aachen"
    }

    return locations[uni]
  end
end
