require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  setup do
    @document = documents(:one)
    @project = projects(:one)
  end


  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document" do
    image = fixture_file_upload 'sample.jpg'
    assert_difference('Document.count') do
      post :create, document: { scene_number: @document.scene_number, 
                                name: "A New Document", 
                                project_id: @project.id,
                                data: image }
    end

    assert_not_nil Document.find_by(name: "A New Document").created_by
    assert_redirected_to document_url(Document.find_by(name: "A New Document"))
  end

  test "should show document" do
    get :show, id: @document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @document
    assert_response :success
  end

  test "should update document" do
    image = fixture_file_upload 'sample.jpg'
    patch :update, id: @document, document: { scene_number: @document.scene_number, 
                                              name: @document.name,
                                              data: image }
    assert_redirected_to document_url(@document)
  end

  test "should destroy document" do
    assert_difference('Document.count', -1) do
      delete :destroy, id: @document
    end

    assert_redirected_to project_path(@project.id)
  end

end
