class Lesson < ApplicationRecord
  belongs_to :laboratory
  belongs_to :disciplina
  has_many :anexos, foreign_key: 'anexo_id'
  
  #mount_uploader :solicitacao_aula, SolicitacaoAulaUploader

  def self.week_day(day)
    case day
    when 'dom'
      return 0
    when 'seg'
      return 1
    when 'ter'
      return 2
    when 'qua'
      return 3
    when 'qui'
      return 4
    when 'sex'
      return 5
    when 'sab'
      return 6
    end
  end

end
