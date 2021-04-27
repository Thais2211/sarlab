class LaboratoySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :active, :escola, :created_at, :updated_at, :local

  belongs_to :escola
end
