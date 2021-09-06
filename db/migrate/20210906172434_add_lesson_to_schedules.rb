class AddLessonToSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_column :lessons, :solicitacao_aula, :string
    add_column :schedules, :lesson_id, :bigint
  end
end
