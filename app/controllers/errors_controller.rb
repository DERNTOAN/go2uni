class ErrorsController < ApplicationController
  def not_found
    raise
  end

  def internal_error
    raise
  end
end
