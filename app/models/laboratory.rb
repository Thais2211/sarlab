class Laboratory < ApplicationRecord
  belongs_to :escola
  has_many :schedules
  has_many :anexos, foreign_key: 'anexo_id'

end
