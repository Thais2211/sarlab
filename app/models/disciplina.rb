class Disciplina < ApplicationRecord
  belongs_to :professor, class_name: 'User'
  belongs_to :escola

  validates :nome, :professor_id, :escola_id, presence: true
end
