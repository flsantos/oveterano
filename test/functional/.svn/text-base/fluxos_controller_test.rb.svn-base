require 'test_helper'

class FluxosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fluxos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fluxo" do
    assert_difference('Fluxo.count') do
      post :create, :fluxo => { }
    end

    assert_redirected_to fluxo_path(assigns(:fluxo))
  end

  test "should show fluxo" do
    get :show, :id => fluxos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => fluxos(:one).to_param
    assert_response :success
  end

  test "should update fluxo" do
    put :update, :id => fluxos(:one).to_param, :fluxo => { }
    assert_redirected_to fluxo_path(assigns(:fluxo))
  end

  test "should destroy fluxo" do
    assert_difference('Fluxo.count', -1) do
      delete :destroy, :id => fluxos(:one).to_param
    end

    assert_redirected_to fluxos_path
  end
end
