require 'test_helper'
require 'aws/s3'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @project.created_by = users(:two).id
    @project.send(:create_bucket)
  end

  teardown do
    cleanup_buckets("#{Rails.env}-#{users(:two).id}-#{@project.name.parameterize}")
  end


  def cleanup_buckets(bucket)
    s3 = AWS::S3.new
    bucket_name_on_s3 = s3.buckets[bucket]
    if bucket_name_on_s3.exists?
      bucket_name_on_s3.delete
    end
  end


  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { name: "The Test One" }
    end

    assert_not_nil Project.find_by(name:"The Test One").created_by
    assert_redirected_to project_path(assigns(:project))
    cleanup_buckets("#{Rails.env}-#{users(:one).id}-the-test-one")
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    patch :update, id: @project, project: { name: @project.name }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end

  test "should remove current project from session if destroyed" do
    session[:current_project] = @project.id
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end
    assert_nil session[:current_project]
    assert_redirected_to projects_path
  end
end
