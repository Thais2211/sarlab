class Equipament < ApplicationRecord
  belongs_to :laboratory
  has_many :anexos, foreign_key: 'anexo_id'

  mount_uploader :image, ImageEquipamentsUploader
  
end
