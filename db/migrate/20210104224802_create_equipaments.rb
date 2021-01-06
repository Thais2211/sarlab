class CreateEquipaments < ActiveRecord::Migration[5.2]
  def change
    create_table :equipaments do |t|
      t.string :name
      t.string :description
      t.string :brand
      t.string :model
      t.string :capacity
      t.string :patrimony
      t.references :laboratory, foreign_key: true
      t.integer :simultaneous_use

      t.timestamps
    end
  end
end
