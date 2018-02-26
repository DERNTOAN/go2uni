class MyrequestsController < ApplicationController
  def index
    @requests = policy_scope(Request)
  end

  def show
    @request = request.find(params[:id])
    authorize @request
  end
end
