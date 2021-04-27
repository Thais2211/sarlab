class UserSerializer < ActiveModel::Serializer
  attributes :id, :nome, :ra, :email, :celular, :ativo, :escola, :permissao

  belongs_to :escola

  def permissao
    object.role.permissao
  end
end
