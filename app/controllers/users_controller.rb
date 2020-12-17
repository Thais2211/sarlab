class UsersController < ApplicationController
  #skip_before_action :verify_authenticity_token
  #before_filter :authorize_admin, only: [:create, :new, :edit, :index]
  before_action :set_usuario, only: [:edit, :update, :destroy, :editar_usuario, :alterar_senha, :toggle_user,
                :alter_permission]

  def index
    @alunos = User.where(ativo: true, role_id: 3)
    @professores = User.where(ativo: true, role_id: 2)
    @admins = User.where(ativo: true, role_id: 1)
    @inativos = User.where(ativo: false)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.ativo = true
    @user.permissao_id = 1

    respond_to do |format|
      if @user.save
        flash[:success] = 'Usuário criado com sucesso'
        format.html { redirect_to users_path }
      else
        flash[:error] =  @user.errors.full_messages.to_sentence
        format.html { render action: 'new' }
      end
    end
  end

  def edit
  end

  #put
  def update
    byebug
    respond_to do |format|
      if @user.update(user_update_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_user
    @user.ativo = !@user.ativo
    @user.save

    redirect_to users_path, notice:'Usúario atualizado com sucesso.'
  end

  def alter_permission
    @user.role_id = params[:role_id]
    @user.save
    redirect_to users_path, notice:'Usúario atualizado com sucesso.'
  end

  private

  def set_usuario
    @user = User.find(params[:id])    
  end

  def user_params
    params[:user].permit(:nome, :ra, :email, :celular, :password, :password_confirmation, :permissao_id)
  end

  def user_update_params
    params[:user].permit(:nome, :ra, :email, :celular, :ativo, :permissao_id)
  end
end
