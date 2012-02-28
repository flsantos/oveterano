require 'test_helper'

class CampiControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campi)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campus" do
    assert_difference('Campus.count') do
      post :create, :campus => { }
    end

    assert_redirected_to campus_path(assigns(:campus))
  end

  test "should show campus" do
    get :show, :id => campi(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => campi(:one).to_param
    assert_response :success
  end

  test "should update campus" do
    put :update, :id => campi(:one).to_param, :campus => { }
    assert_redirected_to campus_path(assigns(:campus))
  end

  test "should destroy campus" do
    assert_difference('Campus.count', -1) do
      delete :destroy, :id => campi(:one).to_param
    end

    assert_redirected_to campi_path
  end
end
