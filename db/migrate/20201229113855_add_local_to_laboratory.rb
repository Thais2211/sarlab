class AddLocalToLaboratory < ActiveRecord::Migration[5.2]
  def change
    add_column :laboratorys, :local, :string
  end
end
