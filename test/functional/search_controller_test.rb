require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get checktype" do
    get :checktype
    assert_response :success
  end

  test "should get startspecific" do
    get :startspecific
    assert_response :success
  end

  test "should get startgeneric" do
    get :startgeneric
    assert_response :success
  end

  test "should get specific" do
    get :specific
    assert_response :success
  end

  test "should get generic" do
    get :generic
    assert_response :success
  end

end
