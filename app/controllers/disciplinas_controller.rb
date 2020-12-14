class DisciplinasController < ApplicationController
  before_action :set_disciplina, only: [:show, :edit, :update, :destroy]

  # GET /disciplinas
  # GET /disciplinas.json
  def index
    @disciplinas = Disciplina.all
  end

  # GET /disciplinas/1
  # GET /disciplinas/1.json
  def show
  end

  # GET /disciplinas/new
  def new
    @disciplina = Disciplina.new
  end

  # GET /disciplinas/1/edit
  def edit
  end

  # POST /disciplinas
  # POST /disciplinas.json
  def create
    byebug
    @disciplina = Disciplina.new(disciplina_params)

    respond_to do |format|
      if @disciplina.save
        format.html { redirect_to @disciplina, notice: 'Disciplina was successfully created.' }
        format.json { render :show, status: :created, location: @disciplina }
      else
        format.html { render :new }
        format.json { render json: @disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disciplinas/1
  # PATCH/PUT /disciplinas/1.json
  def update
    respond_to do |format|
      if @disciplina.update(disciplina_params)
        format.html { redirect_to @disciplina, notice: 'Disciplina was successfully updated.' }
        format.json { render :show, status: :ok, location: @disciplina }
      else
        format.html { render :edit }
        format.json { render json: @disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disciplinas/1
  # DELETE /disciplinas/1.json
  def destroy
    @disciplina.destroy
    respond_to do |format|
      format.html { redirect_to disciplinas_url, notice: 'Disciplina was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def nova_disciplina
    @disciplina = Disciplina.new(nome: params[:nome], escola_id: params[:escola_id], professor_id: params[:professor_id])
    @disciplina.save!

    redirect_to disciplinas_path, notice:'Disciplina cadastrada com sucesso'
    # respond_to do |format|
    #   if @disciplina.save
    #     @disciplinas = Disciplina.all
    #     format.html { render 'index' , notice: 'Disciplina cadastrada com sucesso' }
    #     format.json { render :index }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @disciplina.errors, status: :unprocessable_entity }
    #   end
    # end

    #render json: @disciplina
  end


  def find_professor
    professores = User.where(role_id: 2, ativo: true, escola_id: params[:escola])
    
    render json: professores
  end

  def get_disciplina
    disciplina = Disciplina.find(params[:id])

    render json: disciplina
  end

  def atualizar_disciplina
    byebug
    disciplina.update(nome: params[:nome], escola_id: params[:escola_id], professor_id: params[:professor_id]);
    disciplina.save!

    render json: disciplina
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disciplina
      @disciplina = Disciplina.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def disciplina_params
      params.require(:disciplina).permit(:nome, :professor_id, :escola_id)
    end
end
