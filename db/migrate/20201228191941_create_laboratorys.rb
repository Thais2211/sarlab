class CreateLaboratorys < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratorys do |t|
      t.string :name
      t.string :description
      t.boolean :active, default: true
      t.references :escola, foreign_key: true

      t.timestamps
    end
  end
end
