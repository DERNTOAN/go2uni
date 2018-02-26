class MyrequestsController < ApplicationController
  def index
    @myrequests = policy_scope(Request).where("user_id = #{params[:id]}")
  end

  def show
    @myrequest = Request.find(params[:id])
    authorize @myrequest
  end
end
