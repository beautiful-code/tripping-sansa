require 'test_helper'

class SayingsControllerTest < ActionController::TestCase
  setup do
    @saying = sayings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sayings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saying" do
    assert_difference('Saying.count') do
      post :create, saying: { text: @saying.text }
    end

    assert_redirected_to saying_path(assigns(:saying))
  end

  test "should show saying" do
    get :show, id: @saying
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saying
    assert_response :success
  end

  test "should update saying" do
    put :update, id: @saying, saying: { text: @saying.text }
    assert_redirected_to saying_path(assigns(:saying))
  end

  test "should destroy saying" do
    assert_difference('Saying.count', -1) do
      delete :destroy, id: @saying
    end

    assert_redirected_to sayings_path
  end
end
