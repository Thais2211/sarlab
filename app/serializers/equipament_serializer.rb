class EquipamentSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :brand, :model, :capacity, :patrimony, :laboratory, :simultaneous_use

  belongs_to :laboratory
end
