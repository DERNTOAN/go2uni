class RequestsController < ApplicationController
    skip_before_action :authenticate_user!, only: :index

  def index
    @request = policy_scope(Request)
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
    @request = Request.create(request_params)
    authorize @request

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def request_params
    params.require(:request).permit(:user_id, :start_time, :stop_time, :from_lng, :from_lat, :to_lng, :to_lat)
  end
end
