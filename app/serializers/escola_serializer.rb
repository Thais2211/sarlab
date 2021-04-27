class EscolaSerializer < ActiveModel::Serializer
  attributes :id, :nome, :endereco, :numero, :cidade, :responsavel, :telefone, :created_at, :updated_at
end
