class UsersController < ApplicationController
  #skip_before_action :verify_authenticity_token
  #before_filter :authorize_admin, only: [:create, :new, :edit, :index]
  before_action :set_usuario, only: [:edit, :update, :destroy, :editar_usuario, :alterar_senha]

  def index
    @users = User.where(ativo: true)
    @users_inativos = User.where(ativo: false)
  end

  def new
    @user = User.new
  end

  def create
    byebug
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

  private

  def set_usuario
    #@user = current_user.admin? ? User.find(params[:id].present? ? params[:id] : current_user.id) : current_user
  end

  def user_params
    params[:user].permit(:nome, :ra, :email, :celular, :password, :password_confirmation, :permissao_id)
  end

  def user_update_params
    params[:user].permit(:nome, :ra, :email, :celular, :ativo, :permissao_id)
  end
end
