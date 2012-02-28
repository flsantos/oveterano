require 'test_helper'

class HabilitacoesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:habilitacoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create habilitacao" do
    assert_difference('Habilitacao.count') do
      post :create, :habilitacao => { }
    end

    assert_redirected_to habilitacao_path(assigns(:habilitacao))
  end

  test "should show habilitacao" do
    get :show, :id => habilitacoes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => habilitacoes(:one).to_param
    assert_response :success
  end

  test "should update habilitacao" do
    put :update, :id => habilitacoes(:one).to_param, :habilitacao => { }
    assert_redirected_to habilitacao_path(assigns(:habilitacao))
  end

  test "should destroy habilitacao" do
    assert_difference('Habilitacao.count', -1) do
      delete :destroy, :id => habilitacoes(:one).to_param
    end

    assert_redirected_to habilitacoes_path
  end
end
