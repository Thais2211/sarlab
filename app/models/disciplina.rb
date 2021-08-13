class Disciplina < ApplicationRecord
  belongs_to :professor, class_name: 'User'
  belongs_to :escola
  has_many :anexos, foreign_key: 'anexo_id'

  validates :nome, :professor_id, :escola_id, presence: true
end
