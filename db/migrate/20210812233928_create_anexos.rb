class CreateAnexos < ActiveRecord::Migration[5.2]
  def change
    create_table :anexos do |t|
      t.integer :equipament_id
      t.integer :disciplina_id
      t.integer :laboratory_id
      t.integer :lesson_id
      t.string :file

      t.timestamps
    end
  end
end
