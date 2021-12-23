class AddActiveToEquipaments < ActiveRecord::Migration[5.2]
  def change
    add_column :equipaments, :active, :boolean, default: true
    add_column :disciplinas, :active, :boolean, default: true
  end
end
