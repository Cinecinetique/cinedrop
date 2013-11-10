require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user and worker" do
    initial_worker_count = Worker.count
    assert_difference('User.count') do
      post :create, :user =>  { :email => 'Neil@foobar.com', 
        :password =>'secret', 
        :password_confirmation => 'secret',
        :workers_attributes => { '0' => { 'role' => 'director', 'department' => 'Production', 'project_id' => projects(:one).id}}
      }
    end
    assert_equal initial_worker_count+1, Worker.count
    assert_redirected_to users_path
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should post invite" do
    @project = projects(:one)
    post :invite, email: @user.email, project_id: @project
    assert_redirected_to project_url(@project)
  end

  test "should update user" do
    patch :update, id: @user, user: { email: 'Neil@foobar.com', password: 'secret', password_confirmation: 'secret' }
    assert_redirected_to users_path
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
