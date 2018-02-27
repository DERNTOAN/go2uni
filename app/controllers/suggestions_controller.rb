class SuggestionsController < ApplicationController
  def index
    @suggestions = policy_scope(Request)
    raise
  end
end
