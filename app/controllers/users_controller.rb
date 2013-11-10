class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #skip_before_action :authorize, only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    if session[:current_project] && Project.ids.include?(session[:current_project])
      @workers = Worker.where("project_id = #{session[:current_project]}")
      @users = @workers.map { |w| w.user}
    else
      @workers = []
      @users = []
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @worker = Worker.new
    @user.workers.build
  end

  # GET /users/1/edit
  def edit
    @user.workers.build
  end

  # POST /users/invite/[:user_email,:project_id]
  def invite
    user = User.find_by_email(params[:email])
    project = Project.find(params[:project_id])
    respond_to do |format|
      if send_invite(project, user)
        format.html { redirect_to project_url(project), notice: "An invite was successfully sent to #{user.email} " }
        format.json { render action: 'show', status: :created, location: project }
      else
        format.html { redirect_to project_url(project) }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User #{@user.email} was successfully created." }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: "User #{@user.email} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :workers_attributes => [:id, :role, :department, :project_id])
    end

    def send_invite(project, user)
      begin
        InvitationMailer.email_invitation(project, user).deliver
      rescue Exception => ex
        Rails.logger.error("Error when sending invitation email to #{user.email}")
      end
    end
end
