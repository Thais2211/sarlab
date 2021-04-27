class AddTitleToLesson < ActiveRecord::Migration[5.2]
  def change
    remove_column :lessons, :professor_id, :references
    add_reference :lessons, :disciplina, foreign_key: true, after: "laboratory_id"
  end
end
