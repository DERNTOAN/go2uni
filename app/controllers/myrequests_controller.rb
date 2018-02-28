class MyrequestsController < ApplicationController
  def index
    @myrequests = policy_scope(Request).where("user_id = #{params[:id]}")
    @offers = Offer.all
  end

  def show
    @myrequest = Request.find(params[:id])
    @offers = Offer.where(request_id = @myrequest.id)
    authorize @myrequest
  end
end
