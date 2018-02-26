class SuggestionsController < ApplicationController
  def index
    @suggestions = policy_scope(Request)

  end
end
