require File.dirname(__FILE__) + '/../test_helper'

class BelongingsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:belongings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_belonging
    assert_difference('Belonging.count') do
      post :create, :belonging => { }
    end

    assert_redirected_to belonging_path(assigns(:belonging))
  end

  def test_should_show_belonging
    get :show, :id => belongings(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => belongings(:one).id
    assert_response :success
  end

  def test_should_update_belonging
    put :update, :id => belongings(:one).id, :belonging => { }
    assert_redirected_to belonging_path(assigns(:belonging))
  end

  def test_should_destroy_belonging
    assert_difference('Belonging.count', -1) do
      delete :destroy, :id => belongings(:one).id
    end

    assert_redirected_to belongings_path
  end
end
