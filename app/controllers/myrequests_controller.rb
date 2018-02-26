class MyrequestsController < ApplicationController
  def index
    @myrequests = policy_scope(Request).where("user_id = #{params[:id]}")
  end

  def show
    @myrequest = request.find(params[:id])
    authorize @request
  end
end
