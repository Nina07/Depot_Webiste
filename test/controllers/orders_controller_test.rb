require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destory" do
    get :destory
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
