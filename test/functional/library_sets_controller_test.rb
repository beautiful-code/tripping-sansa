require 'test_helper'

class LibrarySetsControllerTest < ActionController::TestCase
  setup do
    @library_set = library_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:library_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create library_set" do
    assert_difference('LibrarySet.count') do
      post :create, library_set: { title: @library_set.title }
    end

    assert_redirected_to library_set_path(assigns(:library_set))
  end

  test "should show library_set" do
    get :show, id: @library_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @library_set
    assert_response :success
  end

  test "should update library_set" do
    put :update, id: @library_set, library_set: { title: @library_set.title }
    assert_redirected_to library_set_path(assigns(:library_set))
  end

  test "should destroy library_set" do
    assert_difference('LibrarySet.count', -1) do
      delete :destroy, id: @library_set
    end

    assert_redirected_to library_sets_path
  end
end
