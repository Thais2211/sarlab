class EscolasController < ApplicationController
  before_action :set_escola, only: [:show, :edit, :update, :destroy, :atualizar_escola]

  # GET /escolas
  # GET /escolas.json
  def index
    @escolas = Escola.all
  end

  # GET /escolas/1
  # GET /escolas/1.json
  def show
  end

  # GET /escolas/new
  def new
    @escola = Escola.new
  end

  # GET /escolas/1/edit
  def edit
  end

  # POST /escolas
  # POST /escolas.json
  def create
    @escola = Escola.new(escola_params)

    respond_to do |format|
      if @escola.save
        format.html { redirect_to @escola, notice: 'Escola was successfully created.' }
        format.json { render :show, status: :created, location: @escola }
      else
        format.html { render :new }
        format.json { render json: @escola.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /escolas/1
  # PATCH/PUT /escolas/1.json
  def update
    respond_to do |format|
      if @escola.update(escola_params)
        format.html { redirect_to @escola, notice: 'Escola was successfully updated.' }
        format.json { render :show, status: :ok, location: @escola }
      else
        format.html { render :edit }
        format.json { render json: @escola.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /escolas/1
  # DELETE /escolas/1.json
  def destroy
    @escola.destroy
    respond_to do |format|
      format.html { redirect_to escolas_url, notice: 'Escola was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def nova_escola
    escola = Escola.new(nome: params[:nome], endereco: params[:endereco], numero: params[:numero], bairro: params[:bairro], 
                        cidade: params[:cidade], responsavel: params[:responsavel], telefone: params[:telefone]);
    escola.save!
    render json: escola
  end

  def atualizar_escola
    @escola.update(nome: params[:nome], endereco: params[:endereco], numero: params[:numero], bairro: params[:bairro], 
                        cidade: params[:cidade], responsavel: params[:responsavel], telefone: params[:telefone]);
    @escola.save!

    render json: @escola
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_escola
      @escola = Escola.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def escola_params
      params.require(:escola).permit(:nome, :endereco, :numero, :bairro, :cidade, :responsavel, :telefone)
    end
end
