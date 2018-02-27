require 'test_helper'

class OffersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get offers_create_url
    assert_response :success
  end

end
