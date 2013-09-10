class ScenesController < ApplicationController
  before_action :set_scene, only: [:show, :edit, :update, :destroy]

  # GET /scenes
  # GET /scenes.json
  def index
    @scenes = Scene.where("project_id = #{session[:current_project]}")
    @project = Project.find(session[:current_project])
  end

  # GET /scenes/1
  # GET /scenes/1.json
  def show
  end

  # GET /scenes/new
  def new
    @scene = Scene.new
  end

  # GET /scenes/1/edit
  def edit
  end

  # POST /scenes
  # POST /scenes.json
  def create
    @scene = Scene.new(scene_params)

    respond_to do |format|
      if @scene.save
        format.html { redirect_to scenes_path, notice: 'Scene was successfully created.' }
        format.json { render action: 'show', status: :created, location: @scene }
      else
        format.html { render action: 'new' }
        format.json { render json: @scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scenes/1
  # PATCH/PUT /scenes/1.json
  def update
    respond_to do |format|
      if @scene.update(scene_params)
        format.html { redirect_to scenes_path, notice: 'Scene was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scenes/1
  # DELETE /scenes/1.json
  def destroy
    @scene.destroy
    respond_to do |format|
      format.html { redirect_to scenes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scene
      @scene = Scene.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scene_params
      params.require(:scene).permit(:project_id, :script_story, :script_video, :script_audio, :slugline, :position)
    end
end
