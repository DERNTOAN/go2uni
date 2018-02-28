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
    @offers = Offer.all
    authorize @myrequest
    @markers_from =
      {
        lng: @myrequest.from_lng,
        lat: @myrequest.from_lat,
      }

    @markers_to =
      {
        lng: @myrequest.to_lng,
        lat: @myrequest.to_lat
      }
  end
end
