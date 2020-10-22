class CreateDisciplinas < ActiveRecord::Migration[5.2]
  def change
    create_table :disciplinas do |t|
      t.string :nome
      t.references :professor, foreign_key: {to_table: :users}
      t.references :escola, foreign_key: true

      t.timestamps
    end
  end
end
