class AddSolicitacaoAulaToLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :solicitacao_aula, :string
  end
end
