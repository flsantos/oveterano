require 'test_helper'

class ProfessoresControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:professores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create professor" do
    assert_difference('Professor.count') do
      post :create, :professor => { }
    end

    assert_redirected_to professor_path(assigns(:professor))
  end

  test "should show professor" do
    get :show, :id => professores(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => professores(:one).to_param
    assert_response :success
  end

  test "should update professor" do
    put :update, :id => professores(:one).to_param, :professor => { }
    assert_redirected_to professor_path(assigns(:professor))
  end

  test "should destroy professor" do
    assert_difference('Professor.count', -1) do
      delete :destroy, :id => professores(:one).to_param
    end

    assert_redirected_to professores_path
  end
end
