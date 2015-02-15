require 'test_helper'

class ReportsControllerControllerTest < ActionController::TestCase
  test "should get penguin" do
    get :penguin
    assert_response :success
  end

  test "should get cafe" do
    get :cafe
    assert_response :success
  end

end
