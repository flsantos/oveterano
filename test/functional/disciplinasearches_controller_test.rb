require 'test_helper'

class DisciplinasearchesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:disciplinasearches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create disciplinasearch" do
    assert_difference('Disciplinasearch.count') do
      post :create, :disciplinasearch => { }
    end

    assert_redirected_to disciplinasearch_path(assigns(:disciplinasearch))
  end

  test "should show disciplinasearch" do
    get :show, :id => disciplinasearches(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => disciplinasearches(:one).to_param
    assert_response :success
  end

  test "should update disciplinasearch" do
    put :update, :id => disciplinasearches(:one).to_param, :disciplinasearch => { }
    assert_redirected_to disciplinasearch_path(assigns(:disciplinasearch))
  end

  test "should destroy disciplinasearch" do
    assert_difference('Disciplinasearch.count', -1) do
      delete :destroy, :id => disciplinasearches(:one).to_param
    end

    assert_redirected_to disciplinasearches_path
  end
end
