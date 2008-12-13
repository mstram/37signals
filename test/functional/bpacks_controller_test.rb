require File.dirname(__FILE__) + '/../test_helper'

class BpacksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:bpacks)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_bpack
    assert_difference('Bpack.count') do
      post :create, :bpack => { }
    end

    assert_redirected_to bpack_path(assigns(:bpack))
  end

  def test_should_show_bpack
    get :show, :id => bpacks(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => bpacks(:one).id
    assert_response :success
  end

  def test_should_update_bpack
    put :update, :id => bpacks(:one).id, :bpack => { }
    assert_redirected_to bpack_path(assigns(:bpack))
  end

  def test_should_destroy_bpack
    assert_difference('Bpack.count', -1) do
      delete :destroy, :id => bpacks(:one).id
    end

    assert_redirected_to bpacks_path
  end
end
