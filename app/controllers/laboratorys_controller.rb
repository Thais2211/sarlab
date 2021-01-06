class LaboratorysController < ApplicationController
  before_action :set_laboratory, only: [:show, :edit, :update, :destroy]

  # GET /laboratorys
  # GET /laboratorys.json
  def index
    @laboratorys = Laboratory.all
  end

  def new_laboratory
    @laboratory = Laboratory.new(name: params[:name], description: params[:description], escola_id: 1, local: params[:local])
    @laboratory.save!

    redirect_to laboratorys_path, notice:'Laboratório cadastrado com sucesso'
  end

  def get_laboratory
    laboratory = Laboratory.find(params[:id])

    render json: laboratory
  end

  def edit_laboratory
    @laboratory = Laboratory.find params[:id]
    @laboratory.update(name: params[:name], description: params[:description], local: params[:local])

    redirect_to laboratorys_path, notice:'Laboratório atualizado com sucesso'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_laboratory
      @laboratory = Laboratory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def laboratory_params
      params.require(:laboratory).permit(:name, :description, :active, :escola_id, :local)
    end
end
