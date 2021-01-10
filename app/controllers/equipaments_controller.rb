class EquipamentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_equipament, only: [:show, :edit, :update, :destroy]

  # GET /equipaments
  # GET /equipaments.json
  def index
    @q = Equipament.ransack(params[:q])
    @equipaments = @q.result
    
    #@equipaments = Equipament.all    
  end

  # GET /equipaments/1
  # GET /equipaments/1.json
  def show
  end

  # GET /equipaments/new
  def new
    @equipament = Equipament.new
  end

  # GET /equipaments/1/edit
  def edit
  end

  # POST /equipaments
  # POST /equipaments.json
  def create
    @equipament = Equipament.new(equipament_params)

    respond_to do |format|
      if @equipament.save
        format.html { redirect_to @equipament, notice: 'Equipamento cadastrado com sucesso' }
        format.json { render :show, status: :created, location: @equipament }
      else
        format.html { render :new }
        format.json { render json: @equipament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipaments/1
  # PATCH/PUT /equipaments/1.json
  def update
    respond_to do |format|
      if @equipament.update(equipament_params)
        format.html { redirect_to @equipament, notice: 'Equipamento atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @equipament }
      else
        format.html { render :edit }
        format.json { render json: @equipament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipaments/1
  # DELETE /equipaments/1.json
  def destroy
    @equipament.destroy
    respond_to do |format|
      format.html { redirect_to equipaments_url, notice: 'Equipament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def equipaments_labs
    @equipaments = Equipament.where(laboratory_id: params[:lab])
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipament
      @equipament = Equipament.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def equipament_params
      params.require(:equipament).permit(:name, :description, :brand, :model, :capacity, :patrimony, :laboratory_id, :simultaneous_use)
    end
end
