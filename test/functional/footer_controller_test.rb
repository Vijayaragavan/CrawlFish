require 'test_helper'

class FooterControllerTest < ActionController::TestCase
  test "should get about_us" do
    get :about_us
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get merchant_login" do
    get :merchant_login
    assert_response :success
  end

  test "should get privacy_statement" do
    get :privacy_statement
    assert_response :success
  end

  test "should get speak_to_us" do
    get :speak_to_us
    assert_response :success
  end

end
