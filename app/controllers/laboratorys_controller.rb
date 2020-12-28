class LaboratorysController < ApplicationController
  before_action :set_laboratory, only: [:show, :edit, :update, :destroy]

  # GET /laboratorys
  # GET /laboratorys.json
  def index
    @laboratorys = Laboratory.all
  end

  # GET /laboratorys/1
  # GET /laboratorys/1.json
  def show
  end

  # GET /laboratorys/new
  def new
    @laboratory = Laboratory.new
  end

  # GET /laboratorys/1/edit
  def edit
  end

  # POST /laboratorys
  # POST /laboratorys.json
  def create
    @laboratory = Laboratory.new(laboratory_params)

    respond_to do |format|
      if @laboratory.save
        format.html { redirect_to @laboratory, notice: 'Laboratory was successfully created.' }
        format.json { render :show, status: :created, location: @laboratory }
      else
        format.html { render :new }
        format.json { render json: @laboratory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /laboratorys/1
  # PATCH/PUT /laboratorys/1.json
  def update
    respond_to do |format|
      if @laboratory.update(laboratory_params)
        format.html { redirect_to @laboratory, notice: 'Laboratory was successfully updated.' }
        format.json { render :show, status: :ok, location: @laboratory }
      else
        format.html { render :edit }
        format.json { render json: @laboratory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /laboratorys/1
  # DELETE /laboratorys/1.json
  def destroy
    @laboratory.destroy
    respond_to do |format|
      format.html { redirect_to laboratorys_url, notice: 'Laboratory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_laboratory
    byebug
    @laboratory = Laboratory.new(name: params[:name], description: params[:description], escola_id: 2)
    @laboratory.save!

    redirect_to laboratorys_path, notice:'Laboratório cadastrado com sucesso'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_laboratory
      @laboratory = Laboratory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def laboratory_params
      params.require(:laboratory).permit(:name, :description, :active, :escola_id)
    end
end
