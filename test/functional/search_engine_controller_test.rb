require 'test_helper'

class SearchEngineControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get apply" do
    get :apply
    assert_response :success
  end

end
