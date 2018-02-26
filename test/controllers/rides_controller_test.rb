require 'test_helper'

class RidesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rides_index_url
    assert_response :success
  end

  test "should get show" do
    get rides_show_url
    assert_response :success
  end

  test "should get new" do
    get rides_new_url
    assert_response :success
  end

  test "should get create" do
    get rides_create_url
    assert_response :success
  end

  test "should get edit" do
    get rides_edit_url
    assert_response :success
  end

  test "should get update" do
    get rides_update_url
    assert_response :success
  end

  test "should get destroy" do
    get rides_destroy_url
    assert_response :success
  end

end
