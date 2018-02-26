require 'test_helper'

class MyrequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get myrequests_index_url
    assert_response :success
  end

  test "should get show" do
    get myrequests_show_url
    assert_response :success
  end

end
