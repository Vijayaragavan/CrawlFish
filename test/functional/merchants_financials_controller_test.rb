require 'test_helper'

class MerchantsFinancialsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get fixed" do
    get :fixed
    assert_response :success
  end

  test "should get variable" do
    get :variable
    assert_response :success
  end

  test "should get purchase" do
    get :purchase
    assert_response :success
  end

end
