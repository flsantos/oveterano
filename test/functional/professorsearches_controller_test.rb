require 'test_helper'

class ProfessorsearchesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:professorsearches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create professorsearch" do
    assert_difference('Professorsearch.count') do
      post :create, :professorsearch => { }
    end

    assert_redirected_to professorsearch_path(assigns(:professorsearch))
  end

  test "should show professorsearch" do
    get :show, :id => professorsearches(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => professorsearches(:one).to_param
    assert_response :success
  end

  test "should update professorsearch" do
    put :update, :id => professorsearches(:one).to_param, :professorsearch => { }
    assert_redirected_to professorsearch_path(assigns(:professorsearch))
  end

  test "should destroy professorsearch" do
    assert_difference('Professorsearch.count', -1) do
      delete :destroy, :id => professorsearches(:one).to_param
    end

    assert_redirected_to professorsearches_path
  end
end
