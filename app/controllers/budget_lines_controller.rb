class BudgetLinesController < ApplicationController
  before_action :set_budget_line, only: [:show, :edit, :update, :destroy]

  # GET /budget_lines
  # GET /budget_lines.json
  def index
    @budget_lines = BudgetLine.all
  end

  # GET /budget_lines/1
  # GET /budget_lines/1.json
  def show
  end

  # GET /budget_lines/new
  def new
    @budget_line = BudgetLine.new
  end

  # GET /budget_lines/1/edit
  def edit
  end

  # POST /budget_lines
  # POST /budget_lines.json
  def create
    @budget_line = BudgetLine.new(budget_line_params)

    respond_to do |format|
      if @budget_line.save
        format.html { redirect_to @budget_line, notice: 'Budget line was successfully created.' }
        format.json { render action: 'show', status: :created, location: @budget_line }
      else
        format.html { render action: 'new' }
        format.json { render json: @budget_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budget_lines/1
  # PATCH/PUT /budget_lines/1.json
  def update
    respond_to do |format|
      if @budget_line.update(budget_line_params)
        format.html { redirect_to @budget_line, notice: 'Budget line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @budget_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budget_lines/1
  # DELETE /budget_lines/1.json
  def destroy
    @budget_line.destroy
    respond_to do |format|
      format.html { redirect_to budget_lines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget_line
      @budget_line = BudgetLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_line_params
      params.require(:budget_line).permit(:phase, :position, :item_decription, :unit_definition, :unit_cost, :quantity, :cost, :budget_id, :resource_id)
    end
end
