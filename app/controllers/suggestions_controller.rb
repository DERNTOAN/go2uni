class SuggestionsController < ApplicationController
  def index
    @requests = policy_scope(Request)

  end
end
