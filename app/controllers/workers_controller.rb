class WorkersController < ApplicationController
	before_action :set_worker, only: [:show, :edit, :update, :destroy]
  #skip_before_action :authorize, only: [:new, :create]

  # GET /workers
  # GET /workers.json
  def index
    @workers = Worker.where("project_id = #{session[:current_project]}")
  end

  # GET /workers/1
  # GET /workers/1.json
  def show
  end

  # GET /workers/new
  def new
    project_id =  params[:p] if params[:p] =~ /\d/
    @worker = Worker.new
    @user = User.find(current_user.id)
    @project = Project.find(project_id)
  end

  # GET /workers/1/edit
  def edit
    @worker = Worker.find(params[:id])
    @user = User.find(@worker.user.id)
    @project = Project.find(session[:current_project])
  end

  # POST /workers
  # POST /workers.json
  def create
    @worker = Worker.new(worker_params)

    respond_to do |format|
      if @worker.save
        format.html { redirect_to project_path(@worker.project_id), notice: "User #{@worker.user.name} was successfully added to project #{Project.find(@worker.project_id).name}." }
        format.json { render action: 'show', status: :created, location: @worker }
      else
        format.html { render action: 'new' }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /worker/1
  # PATCH/PUT /workers/1.json
  def update
    respond_to do |format|
      if @worker.update(worker_params)
        format.html { redirect_to project_path(session[:current_project]), notice: "User #{@worker.user.name} was successfully updated in project #{Project.find(session[:current_project]).name}." }
        format.json { render action: 'show', status: :created, location: @worker }
      else
        format.html { render action: 'new' }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workers/1
  # DELETE /workers/1.json
  def destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worker
      @worker = Worker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def worker_params
      params.require(:worker).permit(:role, :department, :user_id, :project_id)
    end
end
