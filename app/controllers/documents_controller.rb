class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
    @project_id = params[:project_id]
  end

  # GET /documents/heartbeat
  def heartbeat
    respond_to :js
  end
  
  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    if document_params[:data] == nil
      logger.warn "**** USING DOCUMENT! ****"
      @document = Document.new(document_params)
    elsif Pdf.content_types.include?(document_params[:data].content_type)
      @document = Pdf.new(document_params)
    elsif Msword.content_types.include?(document_params[:data].content_type)
      @document = Msword.new(document_params)
    elsif Msexcel.content_types.include?(document_params[:data].content_type)
      @document = Msexcel.new(document_params)
    elsif Image.content_types.include?(document_params[:data].content_type)
      @document = Image.new(document_params)
    elsif Video.content_types.include?(document_params[:data].content_type)
      @document = Video.new(document_params)
    elsif Audio.content_types.include?(document_params[:data].content_type)
      @document = Audio.new(document_params)
    else
      logger.warn "**** USING DOCUMENT! ****"
      @document = Document.new(document_params)
    end

    @document.created_by = session[:user_id]
    @document.changed_by = session[:user_id]

    respond_to do |format|
      if @document.save
        format.html { redirect_to document_url(@document) }
        format.json { render action: 'show', status: :created, location: @document }
      else
        format.html { render action: 'new' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update

    @document.changed_by = session[:user_id]

    respond_to do |format|
      if @document.update(document_params(@document.class.to_s))
        format.html { redirect_to document_url(@document) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit'}
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy

    logger.info "document deleted by #{session[:user_id]}"
    project = @document.project
    @document.destroy
    respond_to do |format|
      format.html { redirect_to project }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params(kind = nil)
      if kind
        params.require(kind.downcase.to_sym).permit(:name, :project_id, :data, :scene_number,:data_ref, :data_host)
      else
        params.require(:document).permit(:name, :project_id, :data, :scene_number,:data_ref, :data_host)
      end
    end
end


