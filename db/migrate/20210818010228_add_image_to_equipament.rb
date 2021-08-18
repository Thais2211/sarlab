class AddImageToEquipament < ActiveRecord::Migration[5.2]
  def change
    add_column :equipaments, :image, :string
  end
end
