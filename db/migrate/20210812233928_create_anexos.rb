class CreateAnexos < ActiveRecord::Migration[5.2]
  def change
    create_table :anexos do |t|
      t.references :equipament, foreign_key: true
      t.references :disciplina, foreign_key: true
      t.references :laboratory, foreign_key: true
      t.references :lesson, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end
